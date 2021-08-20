'use strict';

const Discord = require('discord.js');
// const fetch = require('node-fetch');
const fetchTimeout = require('fetch-timeout');
const { paddedFullWidth, errorWrap } = require('./utils.js');

if (Discord.version.startsWith('12.')) {
  // rename functions for compatibilities sake while testing
  Discord.RichEmbed = Discord.MessageEmbed;
  Discord.TextChannel.prototype.fetchMessage = function(snowflake) { // not perfect but whatevs
    return this.messages.fetch.apply(this.messages, [snowflake]);
  }
  Object.defineProperty(Discord.User.prototype, 'displayAvatarURL', {
    'get': function() {
      return this.avatarURL();
    }
  })
}

const LOG_LEVELS = {
  'ERROR': 3,
  'INFO': 2,
  'DEBUG': 1,
  'SPAM': 0
}

const USER_AGENT = `FiveM Status Bot`;

exports.start = function(SETUP) {
  const URL_SERVER = SETUP.URL_SERVER;

  const URL_PLAYERS = new URL('/players.json', SETUP.URL_SERVER).toString();
  const URL_INFO = new URL('/info.json', SETUP.URL_SERVER).toString();
  const MAX_PLAYERS = 64;
  const TICK_MAX = 1 << 9; // max bits for TICK_N
  const FETCH_TIMEOUT = 900;
  const FETCH_OPS = {
    'cache': 'no-cache',
    'method': 'GET',
    'headers': { 'User-Agent': USER_AGENT }
  };

  const LOG_LEVEL = SETUP.LOG_LEVEL !== undefined ? parseInt(SETUP.LOG_LEVEL) : LOG_LEVELS.INFO;
  const BOT_TOKEN = SETUP.BOT_TOKEN;
  const CHANNEL_ID = SETUP.CHANNEL_ID;
  const MESSAGE_ID = SETUP.MESSAGE_ID;
  const UPDATE_TIME = 5000; // in ms

  var TICK_N = 0;
  var MESSAGE;
  var LAST_COUNT;
  var STATUS;

  var loop_callbacks = []; // for testing whether loop is still running

  const log = function(level, message) {
    if (level >= LOG_LEVEL) console.log(`${new Date().toLocaleString()} :${level}: ${message}`);
  };

  const getPlayers = function() {
    return new Promise((resolve, reject) => {
      fetchTimeout(URL_PLAYERS, FETCH_OPS, FETCH_TIMEOUT).then((res) => {
        res.json().then((players) => {
          resolve(players);
        }).catch(reject);
      }).catch(reject);
    })
  };

  const getVars = function() {
    return new Promise((resolve, reject) => {
      fetchTimeout(URL_INFO, FETCH_OPS, FETCH_TIMEOUT).then((res) => {
        res.json().then((info) => {
          resolve(info.vars);
        }).catch(reject);
      }).catch(reject);
    });
  };

  const bot = new Discord.Client();

  const sendOrUpdate = function(embed) {
    if (MESSAGE !== undefined) {
      MESSAGE.edit(embed).then(() => {
        log(LOG_LEVELS.DEBUG, 'Update success');
      }).catch(() => {
        log(LOG_LEVELS.ERROR, 'Update failed');
      })
    } else {
      let channel = bot.channels.cache.get(CHANNEL_ID);
      if (channel !== undefined) {
        channel.fetchMessage(MESSAGE_ID).then((message) => {
          MESSAGE = message;
          message.edit(embed).then(() => {
            log(LOG_LEVELS.SPAM, 'Update success');
          }).catch(() => {
            log(LOG_LEVELS.ERROR, 'Update failed');
          });
        }).catch(() => {
          channel.send(embed).then((message) => {
            MESSAGE = message;
            log(LOG_LEVELS.INFO, `Sent message (${message.id})`);
          }).catch(console.error);
        })
      } else {
        log(LOG_LEVELS.ERROR, 'Update channel not set');
      }
    }
  };   

  const offline = function() {
    log(LOG_LEVELS.SPAM, Array.from(arguments));
    if (LAST_COUNT !== null) log(LOG_LEVELS.INFO, `Server offline ${URL_SERVER} (${URL_PLAYERS} ${URL_INFO})`);
    let time =  '**Last Refreshed:-** '+ new Date().toLocaleString()+' GMT';
    let embed = `**OsmFX Status Bot | Live Server Status**\n\n:x: **| Development Server : \`connect 3bbgbb\` | Server is Currently Offline**\n\n**Please wait while Server comes back Online** |${time}`
    sendOrUpdate(embed);
    LAST_COUNT = null;
  };

  const updateMessage = function() {
    getVars().then((vars) => {
      getPlayers().then((players) => {
        if (players.length !== LAST_COUNT) log(LOG_LEVELS.INFO, `${players.length} players`);
        let queue = vars.sv_queueCount
        let uptime = vars.Uptime
        let ver = '1.0.10' 
        let time =  '**Last Refreshed:-** '+ new Date().toLocaleString()+' GMT';
        if (queue !== undefined) {
          var queue1 = queue // USE IT IF YOU WANT TO
        }
        else {
          var queue1 = 0
        }
        if (uptime !== undefined) {
          var uptime1 = uptime // IF YOU HAVE UPTIME SCRIPT!
        }
        else {
          var uptime1 = 'N/A'
        }

        let embed1 = `**OsmFX - Restarts every 24 hours - Live server status:**\n\n<a:online:841582219302535168>** Development Server : \`connect 3bbgbb\` | Players : ${players.length}/${MAX_PLAYERS} | Uptime : ${uptime1}**\n\n**OsmFX | Server Version: ${ver} |** ${time}`
        sendOrUpdate(embed1);

        LAST_COUNT = players.length;
      }).catch(offline);
    }).catch(offline);
    TICK_N++;
    if (TICK_N >= TICK_MAX) {
      TICK_N = 0;
    }
    for (var i = 0; i < loop_callbacks.length; i++) {
      let callback = loop_callbacks.pop(0);
      callback();
    }
  };

  bot.on('ready', () => {
    log(LOG_LEVELS.INFO, 'Started...');
    bot.setInterval(updateMessage, UPDATE_TIME);
  });

  function checkLoop() {
    return new Promise((resolve, reject) => {
      var resolved = false;
      let id = loop_callbacks.push(() => {
        if (!resolved) {
          resolved = true;
          resolve(true);
        } else {
          log(LOG_LEVELS.ERROR, 'Loop callback called after timeout');
          reject(null);
        }
      })
      setTimeout(() => {
        if (!resolved) {
          resolved = true;
          resolve(false);
        }
      }, 3000);
    })
  }

  bot.on('debug', (info) => {
    log(LOG_LEVELS.SPAM, info);
  })

  bot.on('error', (error, shard) => {
    log(LOG_LEVELS.ERROR, error);
  })

  bot.on('warn', (info) => {
    log(LOG_LEVELS.DEBUG, info);
  })

  bot.on('disconnect', (devent, shard) => {
    log(LOG_LEVELS.INFO, 'Disconnected');
    checkLoop().then((running) => {
      log(LOG_LEVELS.INFO, `Loop still running: ${running}`);
    }).catch(console.error);
  })

  bot.on('reconnecting', (shard) => {
    log(LOG_LEVELS.INFO, 'Reconnecting');
    checkLoop().then((running) => {
      log(LOG_LEVELS.INFO, `Loop still running: ${running}`);
    }).catch(console.error);
  })

  bot.on('resume', (replayed, shard) => {
    log(LOG_LEVELS.INFO, `Resuming (${replayed} events replayed)`);
    checkLoop().then((running) => {
      log(LOG_LEVELS.INFO, `Loop still running: ${running}`);
    }).catch(console.error);
  })

  bot.on('rateLimit', (info) => {
    log(LOG_LEVELS.INFO, `Rate limit hit ${info.timeDifference ? info.timeDifference : info.timeout ? info.timeout : 'Unknown timeout '}ms (${info.path} / ${info.requestLimit ? info.requestLimit : info.limit ? info.limit : 'Unkown limit'})`);
    if (info.path.startsWith(`/channels/${CHANNEL_ID}/messages/${MESSAGE_ID ? MESSAGE_ID : MESSAGE ? MESSAGE.id : ''}`)) bot.emit('restart');
    checkLoop().then((running) => {
      log(LOG_LEVELS.DEBUG, `Loop still running: ${running}`);
    }).catch(console.error);
  })

  bot.login(BOT_TOKEN).then(null).catch(() => {
    log(LOG_LEVELS.ERROR, 'Unable to login check your login token');
    console.log(e);
    process.exit(1);
  });

  return bot;
}
