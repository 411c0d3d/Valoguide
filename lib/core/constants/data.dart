import 'dart:ui';

import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:flutter/material.dart';

Color mapColor(mapName) {
  var mapColors = [Colors.amber, Colors.green, Colors.pink, Colors.cyan];
  switch (mapName.toLowerCase()) {
    case 'split':
      return mapColors[3];
    case 'bind':
      return mapColors[0];
    case 'ascent':
      return mapColors[2];
    case 'haven':
      return mapColors[1];
    default:
      {
        print("Invalid map");
      }
      return Colors.transparent;
  }
}

class WeaponArguments {
  final String weaponType;
  final int weaponIndex;
  WeaponArguments(this.weaponType, this.weaponIndex);
}

class AgentArguments {
  final int agentIndex;
  AgentArguments(this.agentIndex);
}

class MapArguments {
  final int mapIndex;
  final String mapSide;
  final Color mapColor;
  MapArguments(this.mapIndex, this.mapColor, this.mapSide);
}

class PostArgument {
  final Post post;

  PostArgument(this.post);
}

class RoutArgument {
  WeaponArguments weaponArguments;
  AgentArguments agentArguments;
  MapArguments mapArguments;
  PostArgument postArgument;
}

List<String> agentsImages = [
  "assets/images/agents/port/brimstone_port.jpg",
  "assets/images/agents/port/jett_port.jpg",
  "assets/images/agents/port/raze_port.jpg",
  "assets/images/agents/port/cypher_port.jpg",
  "assets/images/agents/port/phoenix_port.jpg",
  "assets/images/agents/port/viper_port.jpg",
  "assets/images/agents/port/sova_port.jpg",
  "assets/images/agents/port/sage_port.jpg",
  "assets/images/agents/port/breach_port.jpg",
  "assets/images/agents/port/reyna_port.jpg",
  "assets/images/agents/port/omen_port.jpg",
];

List<String> agentClass = ['Initiator', 'Duelist', 'Controller', 'Sentinel'];

List<String> agentNames = [
  "Brimstone",
  "Jett",
  "Raze",
  "Cypher",
  "Phoenix",
  "Viper",
  "Sova",
  "Sage",
  "Breach",
  "Reyna",
  "Omen",
];
final List<Agent> agents = [
  //Brimstone
  Agent(
      'Brimstone',
      'Controller',
      'B',
      'USA',
      [
        Ability(
            'Stim Beacon',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'ORnv5UfDzBM',
            'C',
            "EQUIP a stim beacon. FIRE to toss the stim beacon in front of Brimstone. Upon landing, the stim beacon will create a field that grants players RapidFire."),
        Ability(
            'Incendiary',
            '200',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '7vjdkOdpEas',
            'Q',
            "EQUIP an incendiary grenade launcher. FIRE to launch a grenade that detonates as it comes to a rest on the floor, creating a lingering fire zone that damages players within the zone."),
        Ability(
            'Sky Smoke',
            'Free',
            '3',
            'assets/images/agents/abilities/charges/3.png',
            'I2__jdzteUY',
            'E',
            "EQUIP a tactical map. FIRE to set locations where Brimstone's smoke clouds will land. ALTERNATE FIRE to confirm, launching long-lasting smoke clouds that block vision in the selected area."),
        Ability(
            'Orbital Strike',
            '6 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'jC_8aGTWW0k',
            'X',
            "EQUIP a tactical map. FIRE to launch a lingering orbital strike laster at the selected location, dealing high damage-over-time to players caught in the selected area.")
      ],
      "Joining from the USA, Brimstone's orbital arsenal ensures his squad always has the advantage. His ability to deliver utility precisely and from a distance make him an unmatched boots-on-the-ground commander."),
  //jett
  Agent(
      'Jett',
      'Duelist',
      'C',
      'S.Korea',
      [
        Ability(
            'Cloudburst',
            '100',
            '3',
            'assets/images/agents/abilities/charges/3.png',
            'SIYFZGswMbc',
            'C',
            "INSTANTLY throw a projectile that expands into a brief vision-blocking cloud on impact with a surfact. HOLD the ability key to curve the smoke in the direction of your crosshair."),
        Ability(
            'Updraft',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'laqCo3wrdd4',
            'Q',
            "INSTANTLY propel Jett high into the air."),
        Ability(
            'Tailwind',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '93CK9fDyD5A',
            'E',
            "INSTANTLY propel Jett in the direction she is moving. If Jett is standing still she will propel forward."),
        Ability(
            'Blade Storm',
            '6 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'fIakwAMXoG8',
            'X',
            "EQUIP a set of highly accurate throwing knives that recharge on killing an opponent. FIRE to throw a single knife at your target. ALTERNATE FIRE to throw all remaining daggers at your target.")
      ],
      "Representing her home country of South Korea, Jett's agile and evasive fighting style lets her take risks no one else can. She runs circles around every skirmish, cutting enemies before they even know what hit them."),
  //raze
  Agent(
      'Raze',
      'Duelist',
      'B',
      'El Salvador',
      [
        Ability(
            'Boom Bot',
            '100',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '9L1zcKM6-Sc',
            'C',
            "EQUIP a Boom Bot. FIRE will deploy the bot, causing it to travel in a straight line on the ground, bouncing off walls. The Boom Bot will lock on to any enemies in it frontal cone and chase them, exploding for heavy damage if it reaches them."),
        Ability(
            'Blast Pack',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'yz9x4Ypf0SI',
            'Q',
            "INSTANTLY throw a Blast Pack that will stick to surfaces. RE-USE the ability after deployment to detonate, damaging and moving anything hit."),
        Ability(
            'Paint Shells',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '-RUgeNH7Cuw',
            'E',
            "EQUIP a cluster grenade. FIRE to throw the grenade, which does damage and creates sub-munitions, each doing damage to anyone in their range."),
        Ability(
            'Showstopper',
            '6 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'rZAun19tD9E',
            'X',
            "EQUIP a rocket launcher. FIRE shoots a rocket that does massive area damage on contact with anything.")
      ],
      "Raze explodes out of Brazil with her big personality and big guns. With her blunt-force-trauma playstyle, she excels at flushing entrenched enemies and clearing tight spaces with a generous dose of “boom.”"),
  //cypher
  Agent(
      'Cypher',
      'Sentinel',
      'A',
      'Morocco',
      [
        Ability(
            'Trapwire',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'saHuEGcGpYU',
            'C',
            "EQUIP a trapwire. FIRE to place a desctuctible and covert tripwire at the targeted location, creating a line that spans between the placed location and the wall opposite. Enemy players who cross a tripwire will be tethered, and dazed after a short period if they do not destroy the device in time. This ability can be picked up to be REDEPLOYED."),
        Ability(
            'Cyber Cage',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'Jh28VPiVWMI',
            'Q',
            "EQUIP a cyber cage. FIRE to toss the cyber cage in front of Cypher. ACTIVATE to create a zone that blocks vision and slows enemies who pass through it."),
        Ability(
            'Spycam',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'QnF9f-sByQE',
            'E',
            "EQUIP a spycam. FIRE to place the spycam at the targeted location. RE-USE this ability to take control of the camera's view. While in control of the camera, FIRE to shoot a marking dart. This dart will reveal the location of any player struck by the dart."),
        Ability(
            'Neural Theft',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '4Y_mdf38v_A',
            'X',
            "INSTANTLY use on a dead enemy player in your crosshairs to reveal the location of all living enemy players.")
      ],
      "The Moroccan information broker, Cypher is a one-man surveillance network who keeps tabs on the enemy's every move. No secret is safe. No maneuver goes unseen. Cypher is always watching."),
  //Phoenix
  Agent(
      'Phoenix',
      'Duelist',
      'B',
      'UK',
      [
        Ability(
            'Blaze',
            '200',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'EkDGsyCHjmE',
            'C',
            "EQUIP a flame wall. FIRE to create a line of flame that moves forward, creating a wall of fire that blocks vision and damages players passing through it. HOLD FIRE to bend the wall in the direction of your crosshair."),
        Ability(
            'Curveball',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'apxrRIFXO2Y',
            'Q',
            "EQUIP a flare orb that takes a curving path and detonates shortly after throwing. FIRE to curve the flare orb to the left, detonating and blinding any player who sees the orb. ALTERNATE FIRE to curve the flare orb to the right."),
        Ability(
            'Hot Hands',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'DB_O4N3Lr40',
            'E',
            "EQUIP a fireball. FIRE to throw a fireball that explodes after a set amount of time or upon hitting the ground, creating a lingering fire zone that damages enemies."),
        Ability(
            'Run it Back',
            '6 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'haZbXfIhOOU',
            'X',
            "INSTANTLY place a marker at Phoenix's location. while this ability is active, dying or allowing the timer to expire will end this ability and bring Phoenix back to this location with full health.")
      ],
      "Hailing from the U.K., Phoenix's star power shines through in his fighting style, igniting the battlefield with flash and flare. Whether he's got backup or not, he'll rush into a fight on his own terms."),
  //viper
  Agent(
      'Viper',
      'Controller',
      'C',
      'USA',
      [
        Ability(
            'Snake Bite',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'ozvJObMxnbY',
            'C',
            "EQUIP a chemical launcher. FIRE to launch a canister that shatters upon hitting the floor, creating a lingering chemical zone that damages and slows enemies."),
        Ability(
            'Poison Cloud',
            '200',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'W_7hdkvJ_AE',
            'Q',
            "EQUiP a gas emitter. FIRE to throw the emitter that perpetually remains throughout the round. RE-USE the ability to create a toxic gas cloud at the cost of fuel. This ability can be RE-USED more than once and can be picked up to be REDEPLOYED."),
        Ability(
            'Toxic Screen',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '3xRd7U2azeI',
            'E',
            "EQUIP a gas emitter launcher. FIRE to deploy a long line of gas emitters. RE-USE the ability to create a tall wall of toxic gas at the cost of fuel. This ability can be RE-USED more than once."),
        Ability(
            'Vipers Pit',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'nQaMCAtftpQ',
            'X',
            "EQUIP a chemical sprayer. FIRE to spray a chemical cloud in all directions around Viper, creating a large cloud that reduces the vision range and maximum health of players inside of it.")
      ],
      "The American chemist, Viper deploys an array of poisonous chemical devices to control the battlefield and cripple the enemy's vision. If the toxins don't kill her prey, her mind games surely will."),
  //sova
  Agent(
      'Sova',
      'Initiator',
      'A',
      'Russia',
      [
        Ability(
            'Owl Drone',
            '300',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '6vX7vhhXrDA',
            'C',
            "EQUIP an owl drone. FIRE to deploy and take control of movement of the drone. While in control of the drone, FIRE to shoot a marking dart. This dart will reveal the location of any player struck by the dart."),
        Ability(
            'Shock Bolt',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'GE_AyjdPcNA',
            'Q',
            "EQUIP a bow with a shock bolt. FIRE to send the explosive bolt forward, detonating upon collision and damaging players nearby. HOLD FIRE to extend the range of teh projectile. ALTERNATE FIRE to add up to two bounces to this arrow."),
        Ability(
            'Recon Bolt',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '4WX_Ad7dQ9A',
            'E',
            "EQUIP a bow with recon boly. FIRE to send the recon bolt forward, activating upon collision and revealing the location of nearby enemies caught in the line of sight of the bolt. Enemies can destroy this bolt. HOLD FIRE to extend the range of the projective. ALTERNATE FIRE to add up to two bounces to this arrow."),
        Ability(
            'Hunters Fury',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '-Qjs3b4X5jg',
            'X',
            "EQUIP a bow with three long-range, wall-piercing energy blasts. FIRE to release an energy blast in a line in front of Sova, dealing damage and revealing the location of enemies caught in the line. This ability can be RE-USED up to two more times while the ability timer is active.")
      ],
      "Born from the eternal winter of Russia's tundra, Sova tracks, finds, and eliminates enemies with ruthless efficiency and precision. His custom bow and incredible scouting abilities ensure that even if you run, you cannot hide."),
  //sage
  Agent(
      'Sage',
      'Sentinel',
      'S',
      'China',
      [
        Ability(
            'Barrier Orb',
            '300',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'nZRCqqRWzjs',
            'C',
            "EQUIP a barrier orb. FIRE places a solid wall. ALT FIRE rotates the targeter."),
        Ability(
            'Slow Orb',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'pXIhQpOXd6A',
            'Q',
            "EQUIP a slowing orb. FIRE to throw a slowing orb forward that detonates upon landing, creating a lingering field that slows players caught inside of it."),
        Ability(
            'Healing Orb',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'tHQQZ2oWdlk',
            'E',
            "EQUIP a healing orb. FIRE with your crosshairs over a damaged ally to activate a heal-over-time on them. ALT FIRE while Sage is damaged to activate a self heal-over-time."),
        Ability(
            'Resurrection',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'SvtD0G-u44Y',
            'X',
            "EQUIP a resurrection ability. FIRE with your crosshairs placed over a dead ally to begin resurrecting them. After a brief channel, the ally will be brought back to life with full health.")
      ],
      "The stronghold of China, Sage creates safety for herself and her team wherever she goes. Able to revive fallen friends and stave off aggressive pushes, she provides a calm center to a hellish fight."),
  //breach
  Agent(
      'Breach',
      'Initiator',
      'S',
      'Sweden',
      [
        Ability(
            'Aftershock',
            '100',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '2TK7nw3B0kA',
            'C',
            "EQUIP a fusion charge. FIRE the charge to set a slow-acting burst through the wall. The burst does heavy damage to anyone caught in its area."),
        Ability(
            'Flashpoint',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'H6EFvy8Ktxs',
            'Q',
            "EQUIP a blind charge. FIRE the charge to set a fast-acting burst through the wall. The charge detonates to blind all players looking at it."),
        Ability(
            'Fault Line',
            'Free',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'pYqBarWr1ug',
            'E',
            "EQUIP a seismic blast. HOLD FIRE to increase the distance. RELEASE to set off the quake, dazing all players in its zone and in a line up to the zone."),
        Ability(
            'Rolling Thunder',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '7sGnlhoDiY4',
            'X',
            "EQUIP a Seismic Charge. FIRE to send a cascading quake through all terrain in a large cone. The quake dazes and knocks up anyone caught in it.")
      ],
      "Breach, the bionic Swede, fires powerful, targeted kinetic blasts to aggressively clear a path through enemy ground. The damage and disruption he inflicts ensures no fight is ever fair."),
  //Reyna
  Agent(
      'Reyna',
      'Duelist',
      'A',
      'Mexico',
      [
        Ability(
            'Leer',
            '200',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'fNKwnXMg5aM',
            'C',
            "EQUIP an ethereal destructible eye. ACTIVATE to cast the eye a short distance forward. The eye will Nearsight all enemies who look at it."),
        Ability(
            'Devour',
            '100',
            '/4',
            'assets/images/agents/abilities/charges/4.png',
            'ltX5w5lSQic',
            'Q',
            "Enemies killed by Reyna leave behind Soul Orbs that last 3 seconds. INSTANTLY consume a nearby soul orb, rapidly healing for a short duration. Health gained through this skill exceeding 100 will decay over time. If EMPRESS is active, this skill will automatically cast and not consume the orb."),
        Ability(
            'Dismiss',
            'Free',
            '/4',
            'assets/images/agents/abilities/charges/4.png',
            'sqcGRWJwfP0',
            'E',
            "INSTANTLY consume a nearby soul orb, becoming intangible for a short duration. If EMPRESS is active, also become invisible."),
        Ability(
            'Empress',
            '6 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '9AxLprV1Vqo',
            'X',
            "INSTANTLY enter a frenzy, increasing firing speed, equip and reload speed dramatically. Scoring a kill renews the duration.")
      ],
      "Forged in the heart of Mexico, Reyna dominates single combat, popping off with each kill she scores. Her capability is only limited by her raw skill, making her highly dependent on performance."),
  //Omen
  Agent(
      'Omen',
      'Controller',
      'A',
      'Void',
      [
        Ability(
            'Shrouded Step',
            '100',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'AA_pcppmevY',
            'C',
            "EQUIP a shadow walk ability and see its range indicator. FIRE to begin a brief channel, then teleport to the marked location."),
        Ability(
            'Paranoia',
            '200',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            'ur3eailMCbQ',
            'Q',
            "INSTANTLY fire a shadow projectile forward, briefly reducing the vision range of all players it touches. This projectile can pass straight through walls."),
        Ability(
            'Dark Cover',
            'Free',
            '2',
            'assets/images/agents/abilities/charges/2.png',
            'Y6n8hWH3OYY',
            'E',
            "EQUIP a shadow orb and see its range indicator. FIRE to throw the shadow orb to the marked location, creating a long-lasting shadow sphere that blocks vision. HOLD ALTERNATE FIRE while targeting to move the marker further away. HOLD the ability key while targeting to move the marker closer."),
        Ability(
            'From the Shadows',
            '7 Points',
            '1',
            'assets/images/agents/abilities/charges/1.png',
            '_A_7NnTCc_g',
            'X',
            "EQUIP a tactical map. FIRE to begin teleporting to the selected location. While teleporting, Omen will appear as a Shade that can be destroyed by an enemy to cancel his teleport.")
      ],
      "A phantom of a memory, Omen hunts in the shadows. He renders enemies blind, teleports across the field, then lets paranoia take hold as his foe scrambles to learn where he might strike next."),
];
dynamic weaponNames = {
  'sidearm': [
    {'name': "Classic", 'clip': "Z7OC_DW4hZQ", 'card': ''},
    {'name': "Shorty", 'clip': "_HV0_ghqfdg", 'card': ''},
    {'name': "Frenzy", 'clip': "uzof4Jd0zb4", 'card': ''},
    {'name': "Ghost", 'clip': "CaVKc0aOPT4", 'card': ''},
    {'name': "Sheriff", 'clip': "PkkUVXS-zTA", 'card': ''},
  ],
  'smg': [
    {'name': "Stinger", 'clip': "m3k6l8OabX4", 'card': ''},
    {'name': "Spectre", 'clip': "5m4LWt6vM3A", 'card': ''},
  ],
  'shotgun': [
    {'name': "Bucky", 'clip': "4AghCULHTt0", 'card': ''},
    {'name': "Judge", 'clip': "v66CI99Q8VE", 'card': ''},
  ],
  'rifle': [
    {'name': "Bulldog", 'clip': "n8K0mHeCa0Q", 'card': ''},
    {'name': "Guardian", 'clip': "1od_NPGQN5c", 'card': ''},
    {'name': "Phantom", 'clip': "Nq4WuWVp_qs", 'card': ''},
    {'name': "Vandal", 'clip': "7sGzWXDVIUg", 'card': ''},
  ],
  'sniper': [
    {'name': "Marshal", 'clip': "vwvu8sWzC7s", 'card': ''},
    {'name': "Operator", 'clip': "FgHi0jaKnG8", 'card': ''},
  ],
  'heavy': [
    {'name': "Ares", 'clip': "YmrzyS3k4OY", 'card': ''},
    {'name': "Odin", 'clip': "_MLDanAVD1c", 'card': ''},
  ],
};

List<dynamic> maps = [
  {
    'name': "Ascent",
    'cover': 'assets/images/maps/Ascent-cover.jpg',
    'plan': 'assets/images/maps/ascent.png',
    'attackers': [
      "\t\t\tPoint A is the one in the northeastern part of the map (again from the point of view of the attackers). It is fairly open, although there are boxes and nooks and crannies to hide in as a defender. A wooden platform will even give you some height, or the possibility to hide underneath.\n\n\t\t\t\tFrom the attackers' point of view, there are three entry points. The first two will ask you to go through the middle line to get to the point, either through the south-western part of the point or around the wooden platform. The third option will be to force your way through the small corridor that leads to the main entrance of the point to the south.",
      "\t\t\tThe second point of Ascent, B is a bit special because the Spike's landing zone is below the rest of the map. You'll have several hiding places where you can take lines and surprise enemies. You can also go to the balcony in the eastern part of the square to get some height and watch the main entrance.\n\n\t\t\t\tAgain, you will have three entrances as an attacker on this second point and again, two will ask you to go through the middle and the famous central square on the map. You will then be able to exit at the level of the balcony we have just talked about or go all the way around and arrive from the north. Finally, you can try to force your way through the main entrance to the south. Once the Spike is down, you will only have two lines to watch for to prevent the enemies from defusing it, a large building occupying the central part.",
    ],
    'defenders': [
      "\t\t\tPoint A is the one in the northeastern part of the map (again from the point of view of the attackers). It is fairly open, although there are boxes and nooks and crannies to hide in as a defender. A wooden platform will even give you some height, or the possibility to hide underneath.\n\n\t\t\t\tFrom the attackers' point of view, there are three entry points. The first two will ask you to go through the middle line to get to the point, either through the south-western part of the point or around the wooden platform. The third option will be to force your way through the small corridor that leads to the main entrance of the point to the south.",
      "\t\t\tThe second point of Ascent, B is a bit special because the Spike's landing zone is below the rest of the map. You'll have several hiding places where you can take lines and surprise enemies. You can also go to the balcony in the eastern part of the square to get some height and watch the main entrance.\n\n\t\t\t\tAgain, you will have three entrances as an attacker on this second point and again, two will ask you to go through the middle and the famous central square on the map. You will then be able to exit at the level of the balcony we have just talked about or go all the way around and arrive from the north. Finally, you can try to force your way through the main entrance to the south. Once the Spike is down, you will only have two lines to watch for to prevent the enemies from defusing it, a large building occupying the central part.",
    ],
    'mapCovers': [
      "assets/images/mapsCovers/ascent-a.jpg",
      "assets/images/mapsCovers/ascent-b.jpg"
    ]
  },
  {
    'name': "Haven",
    'cover': 'assets/images/maps/Haven-cover.jpg',
    'plan': 'assets/images/maps/haven.png',
    'attackers': [
      "\t\t\tA is tough to get to via A-Long because the defense will most definitely have someone on Heaven or on site in an advantageous position covering the entryway. If you do approach via A-Long, make you smoke out or wall off Heaven entirely - top and bottom - to gain the upper hand and get onto the site.A-Short is a much more preferable approach: Team up to cover every angle once you exit A-Short and move onto the site via Towers and try to get on-site with numbers. Once you breach A-Site, you can use the many boxes to your advantage. We really recommend attacking A in numbers. If you have teammates that communicate and agree to your plan, this will provide a very safe and strategic approach to taking A, allowing you to cover every spot rather than rolling the dice on A-Long.",
      "\t\t\tB is a tricky site to attack, as you can easily get pinched in from the A & C defenders who have an easy rotate here. But if you do decide to go for B, you’ll want to immediately get to B-Back and take cover behind the little wooden shield-wall, which gives you great visibility of the whole room and any rotators coming in. Careful though: The wall in the back is bangable. Also mind that there might already be a defender having taken cover behind there just waiting for you.Getting into B, you will need smokes to block off C-Link and A-Link, from which you can be sure the defense will be rotating over.",
      "\t\t\tLet’s move through the Haven map from left to right and start with C-Site: C-Site is the easiest site to push and can be attacked in two ways: You can approach via C-Long or the Garage area. Pushing onto C via Garage, you will have to go through Bottom Mid and Mid Doors where you’ll always be under threat from Mid Courtyard on the right side. It’s best to have someone smoke or wall off the right side to Mid Courtyard so you don’t get any surprises there and can proceed to the next challenge in C-Window: Whoever is positioned here - and there should always be a defender there - will always have the drop on you and you’ll want to block their view with another smoke/wall.\n\n\t\t\t\tA good Brimstone lends himself well to the attacking side on Haven as his Sky Smoke could even provide cover for his attacking teammates while he’s occupying an entirely different site. At least one agent with good smoke or wall abilities is definitely needed to rush C via Garage and it’s worth it:\n\n\t\t\t\t If you succeed in getting to C via Bottom Mid, Mid Doors and Garage, you can be in planting territory within just 10 seconds.\n\n\t\t\t\tAlternatively you can approach the Spike site via C-Long but it is important to note that the defense has visibility on the entire corridor and it’s a tough one to get through. Without smokes, you will simply be a sitting duck here, so proceed with caution and make use of C-Cubby.\n\n\t\t\t\tSeeing as how C has two entry points with one being particularly quick, it lends itself well to rushing and once you have the plant down, you can use all its defensive options to defend the planted Spike."
    ],
    'defenders': [
      "\t\t\tDefenders first this time: On A-Site, Heaven gives you eyes on all entry points to the site: Ramp via A-Long and Towers via A-Short. Be mindful though, because Heaven will also be the first spot attackers check upon entering A-Site and you can be wall-banged. It’s still always a good idea to have one person up on Heaven though.\n\n\t\t\t\tThis is best teamed up with someone taking cover by the A-Box and covering the Towers entryway, so that the agent on Heaven can fully focus on anyone coming through A-Long. You can also combine that with a third person roaming A Tunnel to support on A-Site while also keeping an eye on B.\n\n\t\t\t\tIt’s good to always have two people on A, as Heaven is really best suited to hold A Long, which often leaves Ramp open. ",
      "\t\t\tOn B you should only have one person - either in Back B or A-Link, especially if you have someone on C-Site covering C Link and acting as a roaming defender for B & C.As B only has one entryway, defending it from just A -Link or C-Link can be good enough. Again, Cypher is really well suited for this job, as he can roam safely with Spycam and Trapwire.\n\n\t\t\t\tIf the attackers do go for B, all you need is good communication as B is an easy rotate for both A & C defenders.",
      "\t\t\tAs defense, you can hold Plat - a metal box on the right side of the site - as you have eyes on attackers coming through Connector via Garage and you can also hold an angle into C-Long. However, the angle you have on C-Long from Plat is admittedly not that great.\n\n\t\t\t\tThe better play here is to use the spot at the far end of the C-Site - behind the site-box - which gives you two much better angles on C-Long via the left and right side. The right side, Logs, also provides a good angle on Connector. Thus, from setting yourself up behind the site-box, you can cover both attacking entryways onto the site.\n\n\t\t\t\tThis is ideally combined with a second agent occupying C-Link & C-Window. Be careful here though: The walls on C-Window are bangable - which can also be used to your advantage. An agent like Cypher is perfect on C-Link & C-Window: He can use his Spycam and Trapwire for vision and roam between C & B-Site - as long as someone is stationed on C-Site and surveying C-Long.\n\n\t\t\t\tTwo people should be enough to hold down C. If you’re feeling really confident, a good Cypher can even lock down C-Site on his own with a well-placed Spycam on C-Long and a Trapwire on Garage."
    ],
    'mapCovers': [
      "assets/images/mapsCovers/haven-a.jpg",
      "assets/images/mapsCovers/haven-b.jpg",
      "assets/images/mapsCovers/haven-c.jpg"
    ]
  },
  {
    'name': "Bind",
    'cover': 'assets/images/maps/Bind-cover.jpg',
    'plan': 'assets/images/maps/bind.png',
    'attackers': [
      "\t\t\tWhen attacking Showers, be mindful of B-Port Exit behind you - you have less than a second to react once you hear the sound of someone teleporting and can easily get pinched between an A defender and a rotating B defender.\n\n\t\t\t\tTaking Showers is difficult as it has a lot of corners that you need to check and is so close-quarters. Even worse is the door from Showers onto A-Site: Yes the goal is in sight, but you might have defenders set up all over A Site, ready to pop you in that Showers door. Phoenix’ ultimate Run It Back can be a gamechanger here as it allows you to get a safe scope on A site, while also maybe securing a kill, allowing the rest of your team to follow up more safely.\n\n\t\t\t\tBe particularly mindful of the angle to your right, Tower, when exiting the Showers-doors: It’s a prime camping spot for defenders. If you approach A-Site via A-Short you have to be aware of aggressive defenders that might push to get the drop on you. Also, once you clear A-Short and get to A-Port, be careful: The whole entry to A-Site can be locked down by the defenders. What you want to do here is have an agent that can wall off the entire entryway so that you can switch up your angle. This also gives you a chance to move on to U-Hall to layer your attack and have several angles. When in doubt make use of the teleporter and pivot your attack to B-Site. ",
      "\t\t\tControl of B-Long gives you control of the teleporters, which really opens up the map: If you’re getting nowhere on B, you can immediately rotate to A. When advancing from B-Long & Garden onto the site, you’ll wanna check for anyone camping behind the site box and the angle to your left. Once you’re on site, you need to check the Elbow area. Attackers coming in from Hookah also have a good shot at any defender on Elbow. Once you take B-Elbow, you have access to B-Hall, which is important for picking off potential rotates once you plant.\n\n\t\t\t\tIf you want to push through Hookah, you usually should take a teammate with you, as there are a lot of angles to check. You’ll also need to use your utility to smoke out the room before entering.\n\n\t\t\t\tWhen planting, most people plant on the attacker-side of the site-box, as it gives you eyes on all entry points. If you’re certain that no one is coming from B-Hall or that you’ve secured it, you can also plant behind the site box. Sometimes people also like to plant within the site box. Yes, this gives you more security but that also goes double for anyone possibly defusing the Spike later on.",
    ],
    'defenders': [
      "\t\t\tHeaven is definitely a prime spot on defense as it offers visibility on all entries to A-Site. Ideally, you have someone with an Operator up here. This makes Heaven your primary spot and anchor for defense. Below you set up the support for Heaven: Behind the site-boxes and/or Truck you can move around to have good angles onto A-Short and Showers. Even better though is setting up right below Heaven: From here you have visibility on both Showers and A-Short without moving. Careful however: When you peek on Showers (that’s an odd little sentence), you’re vulnerable to an attack for A-Short unless you move to use the site boxes for cover.\n\n\t\t\t\tShowers is perfect for shotgun eco rounds: It only has one entry way and you can hug the wall and play the corners with your shotty.\n\n\t\t\t\tWhile contesting the teleporter on B is crucial, contesting A-Port is much less important as the teleport itself covers less distance. Also: If the enemy team does teleport, don’t necessarily chase after them immediately. Often it’s better to rotate to B through your spawn. This might catch the enemy off guard, rather than you falling into their trap by teleporting after them. ",
      "\t\t\tLet’s move through the Bind map from left to right: B has two entryways for the attackers, Hookah & B-Window as well as B-Long & Garden. A good strategy for the defense is to plant someone to the left of B Site at B-Cubby in order to lock down anybody coming through B-Long. While you can peek into Hookah from here, you expose yourself while you do, so peek with caution (always peek with caution, life lessons here, folks).\n\n\t\t\t\tAnother good spot on B is defending from behind the site box: From here you can defend Garden as well as Hookah.\n\n\t\t\t\tDefending from way back and shooting out the opening on B-Hall is not preferable as you have no eyes on who is coming via B-Long and can’t stop the attackers from planting.\n\n\t\t\t\tHowever, B-Elbow is a solid spot and gives you the drop on anyone coming onto the site via Garden. Also, any peekers from B-Window are also within your crosshairs with just a tiny flick. The downside here on B-Elbow is that you have no cover.\n\n\t\t\t\tAnother tactic is to set one defender up inside Hookah, as attackers have to check a lot of angles when entering, which you can use to your advantage and stop them before they even get close to B-Site. On Eco rounds, you can use a shotgun in Hookah as it is all close-quarters in there and you’ll have the drop on most attackers entering.\n\n\t\t\t\tThe priority on defense is to defend B-Long as it gives the enemy access to the teleporter on B-Port, which gives them a direct and immediate link to the other side of the map."
    ],
    'mapCovers': [
      "assets/images/mapsCovers/bind-a.jpg",
      "assets/images/mapsCovers/bind-b.jpg"
    ]
  },
  {
    'name': "Split",
    'cover': 'assets/images/maps/Split-cover.jpg',
    'plan': 'assets/images/maps/split.png',
    'attackers': [
      "\t\t\tAs attackers, it’s very important to keep in mind that the Defense might have rushed A Main and could be anticipating your approach from A-Lobby. So peek carefully and once you clear, make sure you also peek Ramps carefully as well - especially if they’re doing well on economy, because they might have an Operator user stationed on Ramps. It’s best to use walls or other abilities to block the vision from Ramp to A-Main.\n\n\t\t\t\tNow the dangerous part is the open area on A-Site below Rafters. You’ll definitely need your abilities and communication to provide cover and safety here. Be extra mindful of players camping Screen, as they have a clear shot on you unless you use utility.\n\n\t\t\t\tGenerally, due to the lack of cover, A Site requires a quick push and quick plant. Once the defense rotates over, they will pretty much catch you out in the open. So don’t waste your time on A - this needs to be done quickly.\n\n\t\t\t\tOnce you do get a plant on A - you can use the same angles as the defense to hold. A Screen, again, is a very good spot to hold and catch defenders that are rotating over from Mid or B. ",
      "\t\t\tAttack on B is tricky because getting through the bottleneck is the only direct way onto B and it's difficult. There are just a so many angles to check and so many options for the defense. \n\n\t\t\t\tThe best move, as soon as you exit the bottleneck onto B, is to block off the right side leading to B-Heaven, which eliminates a couple of angles that the defense can attack you from. Any agent with a wall ability - or even with smokes - can get that job done. This will make getting site control so much easier. Once you do take control and are defending the plant, you can use the many angles and corners to your own advantage.\n\n\t\t\t\tAlways be on your toes though: The defensive help can rotate from Mid very quickly and they have multiple access points to the site, not just one bottleneck. Often times they will come in from Heaven or rotate over via their spawn access point and B-Alley. A good way to cut off the rotate ability is to send someone to meet the defenders in Middle Mail and not wait for them to get to B. Good communication is the key here.",
      "\t\t\tThe main thing for defense on Mid is that you absolutely have to hold it at all costs. If you lose Mid, you’re opening up the entire map for the attacking team and giving them a massive advantage. Delay, kill, confuse… whatever you have to do to keep the attackers from advancing through middle is the task here.\n\n\t\t\t\tTo do that a lot of players use covers spots in Mid Vent or Mid Mail and keep the attackers at bay in Bottom Mid. Contesting Mid is crucial. The longer it takes the attackers to advance here, the better. \n\n\t\t\t\tA neat trick in eco rounds is to buy a shotgun and wait to the left side of the entry-bottleneck in Top-Mid facing Mid-Mail. Hug the wall and wait to blast unsuspecting attackers from close range as they have no other option to get onto Top Mid.      "
    ],
    'defenders': [
      "\t\t\tThere are two ways to defend A-Site on Split - either aggressively or more conservatively. The aggressive way is to defend and contend the corners leading onto the site by taking A-Ramp and setting up on A-Main. The alternative is to play A more defensively and use the on-site angles from Screens to contest the site. Screens gives you safe view on both entryways to A: Heaven/Rafters and A-Main.\n\n\t\t\t\tSince there is almost no cover on A-Site, setting up on Screens is a really safe way to defend, especially when holding the off-angle.\n\n\t\t\t\tAnother option is to hide behind the sign in the back of the actual A Spike site and surprise wannabe planters. It’s important to keep in mind though, that the sign is fully bangable and doesn’t provide safe cover or escape options. Some players might even preemptively empty a clip into the sign.",
      "\t\t\tA solid tactic on Split is to only have one player anchor on B-Site and have two players on middle and two on A. The main reason for that being that the middle players can rotate to B really quickly and that B-Site has a lot of defensive hiding spots.\n\n\t\t\t\tAs a sole B anchor, you have to play it safe - not too much peeking and always ask for help as soon as you need it: It’s a very fast rotate from Mid to B.\n\n\t\t\t\tThere are a lot of angles for the defender to hold and lots of cover to use. Essentially you only have to cover the bottleneck from B-Main leading to B-Site, which can be done from just about any cover: You can set up behind or up on one of the many boxes or below B-Heaven or B-Rafters. You really have to play the angles here and make sure you can get from cover to cover safely. Also, be extra mindful of cover with bangable walls.\n\n\t\t\t\tAttackers will never know where to look because there are a lot of angles to check. It’ll be hard to find you and you might get the drop on someone. Plus, the attackers careful approach might cause them to waste a lot of time, so try to amplify that as much as possible.",
      "\t\t\tAny competent defense will be making sure to not lose Mid, so its important as attackers to at least contend and keep the defenders on Mid busy and away from your teammates who are trying to plant. Ideally, you use your abilities to get the defenders to peek and/or leave cover.\n\n\t\t\t\tAgents like Breach with all his wallbang utility are well suited here, as most of the time the defense will just be behind cover, waiting for you to come through the bottleneck. Whatever you can do to get the defense to leave the safety of their cover and engage early is what you’re going for.\n\n\t\t\t\tAn odd tactic here is that one attacker will go for the ultimate orb that’s in clear sight on Bottom Mid and try to bait defenders to attack him. This only works with good communication though: You need to have a teammate with solid aim picking of greedy, peeking defenders or this plan is just a suicide mission.\n\n\t\t\t\tMost of the time you should at least have two attackers covering Mid - one coming from Sewer and one from B-Link. You can then have one peeking from each side - one peeking Mid Mail and the other Mid Vent. If there is no one in Mid Vent, you can rotate over and attack the Mid Mail together - or vice versa - to maybe gain the advantage. Once you capture Mid, you can set the tempo for the entire match: Rotating onto B becomes almost instant and the defense can quickly get overwhelmed since they don’t have the advantage in holding down the three bottlenecks anymore.\n\n\t\t\t\tA-Site doesn’t open up quite as much though, as the defenders still have a solid defensive advantage in covering the ropes in Mid Vent. Bonus tip: Don’t forget that you still have good accuracy while on the ropes."
    ],
    'mapCovers': [
      "assets/images/mapsCovers/split-a.jpg",
      "assets/images/mapsCovers/split-b.jpg",
      "assets/images/mapsCovers/split-mid.jpg"
    ]
  },
];

final dashIcons = {
  'agents': 'assets/images/dashboard/agentsIcon.png',
  'weapons': "assets/images/dashboard/weaponsIconMini.png",
  'maps': "assets/images/dashboard/mapsIcon.png",
  'tips': "assets/images/dashboard/tipsIcon.png",
  "news": "assets/images/dashboard/newsIcon.png",
  'events': "assets/images/dashboard/eventsIcon.png",
};

final routes = {
  'agents': '/agentsPage',
  'weapons': '/weaponsPage',
  'maps': '/mapsPage',
  'tips': '/tipsPage',
  'news': '/newsPage',
  'events': '/eventsPage',
};

final dashColors = {
  'agents': 0xFFE53645,
  'weapons': 0xFF8359ff,
  'maps': 0xFF29858B,
  'tips': 0xFFE4E9F4,
  'news': 0xFF4975FF,
  'events': 0xFFE7C408,
};

class Ability {
  final name;
  final cost;
  final charge;
  final clipId;
  final description;
  final key;
  final chargeIcon;

  Ability(
    this.name,
    this.cost,
    this.charge,
    this.chargeIcon,
    this.clipId,
    this.key,
    this.description,
  );
}

class Agent {
  final name;
  final rank;
  final type;
  final origin;
  final List<Ability> abilities;
  final description;
  Agent(this.name, this.type, this.rank, this.origin, this.abilities,
      this.description);
}

const YOUTUBE_API_KEY = "AIzaSyAAJ5he_Zs_8DYXkBCFrFrgtRNA1WcPXJ4";

const ADMOB_APP_ID = 'ca-app-pub-7091168394964981~2110788989';
const BANNER_AD_UNIT = 'ca-app-pub-7091168394964981/1423219818';
const INTERSTITIAL_AD_UNIT = 'ca-app-pub-7091168394964981/1402381977';
