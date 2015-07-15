-- Sportrakker database generation script
--  Will generate the nececessary tables for project Sportrakker


-- Tables relating to general user information.
-- Create the user relationship table
CREATE TABLE users(
  user_id    INT(7) NOT NULL AUTO_INCREMENT,
  user_mail   varchar(50),
  user_pass  varchar(50),
  PRIMARY KEY (user_id)
) type = MyISAM;

-- Create table that all people who use the site will associate with
-- \NOTE: user_type denotes what type of user ie a coach vs a player vs a parent
CREATE TABLE people(
  user_id    INT(7) NOT NULL,
  firstname  VARCHAR(50),
  lastname  VARCHAR(50),
  email     VARCHAR(100),
  birth_date CHAR(8),
  gender     CHAR(1),
  address    VARCHAR(50),
  city       VARCHAR(50),
  state_id   INT(2),
  zipcode    VARCHAR(10),
  phone      VARCHAR(15),
  PRIMARY KEY (user_id)
) type = MyISAM;

-- list of different types of user types
CREATE TABLE user_type(
  user_type_id int(1) NOT NULL AUTO_INCREMENT,
  user_type_name VARCHAR(50),
  PRIMARY KEY (user_type_id)
);

-- populate user type table
INSERT INTO user_type VALUES (null,'Athlete'),
  (NULL,'Coach'),
  (NULL,'Parent'),
  (NULL,'Official'),
  (NULL,'Fan');

-- USER LINKAGES TO OTHER ENTITIES
-- creates linkage between followers
CREATE TABLE user_user(
  user_id_a INT(7) NOT NULL,
  user_id_b INT(7) NOT NULL,
  KEY user_id_a (user_id_a),
  KEY user_id_b (user_id_b)
);

-- Relationship between users and teams
-- all users associated with team are linked to it
-- Will then use this for updating
CREATE TABLE user_team(
  user_id INT(7) NOT NULL,
  team_id INT(7) NOT NULL,
  -- will define your relationship to that team
  user_type INT(4),
  KEY user_id(user_id),
  KEY team_id (team_id)
);

-- All of the events that users follow
CREATE TABLE user_events(
  user_id INT(7) NOT NULL,
  event_id INT(7) NOT NULL,
-- will define your relationship to that event
-- if you're participating you'd be an athletes
  user_type INT(4),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- linkage between athletes and sports
-- technically athletes can play different sports
CREATE TABLE user_sports(
  user_id int(7),
  sport_id int(3),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (sport_id) REFERENCES sport(sport_id)
);

-- tags associated with users
-- could be your division, gender, championships
CREATE TABLE user_tags(
  user_id INT(7),
  tag_id INT(4),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);


-- SEPERATE ENTITY TABLES
-- ie tables that are definitive as its own entity
-- Athlete related tables
-- create table to hold athletes
CREATE TABLE athletes(
  user_id INT(7),
  height INT(3),
  weight INT(3),
  nickname VARCHAR(50),
  FOREIGN KEY
);
-- Sport information
CREATE TABLE sport (
  sport_id INT(3) NOT NULL AUTO_INCREMENT,
  sport_name VARCHAR(50),
-- defining characteristics about sport, ex track,running are stored in tags
-- information about rule scripts
  PRIMARY KEY (sport_id)
);

-- Different ways to identify a sport
CREATE TABLE sport_tags(
  sport_id INT(3),
  tag_id INT(4),
  FOREIGN KEY (sport_id) REFERENCES sport(sport_id),
  FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);






-- ----------------------------------------
 -- TEAM TABLES
-- Coaches should have control over team information
CREATE TABLE teams(
  team_id INT(5) NOT NULL AUTO_INCREMENT,
  team_name VARCHAR(50),
  league_id INT(5),
  state_id INT(2),
  PRIMARY KEY (team_id),
  FOREIGN KEY (league_id) REFERENCES leagues(league_id)
);

CREATE TABLE teams_stats(
  team_id int(7),
  stat_id int(7)
);
-- sport to team linkage table
-- Teams can technically be linked to multiple sports
CREATE TABLE team_sport(
  sport_id VARCHAR(3),
  team_id VARCHAR(6)
);





-- LEAGUE TABLES
CREATE TABLE leagues (
  league_id int(5) NOT NULL AUTO_INCREMENT,
  league_name varchar(50),
  state_id INT(2),
  division_id INT(2),
  PRIMARY KEY (league_id)
);

-- Different types od d
CREATE TABLE league_divisions(
  division_id INT(2) NOT NULL,
  division_name CHAR(20),
  PRIMARY KEY (division_id),
  KEY division_name (division_name)
);

-- Populate the divisions table
INSERT into league_divisions VALUES
  (NULL, 'Highschool Track'),
  (NULL, 'Recreational');




-- Event information
CREATE TABLE events (
  event_id    INT(7) NOT NULL AUTO_INCREMENT,
  event_type_id INT(4),
  event_time  DATE,
  event_length TIME,
  event_place VARCHAR(50),
  event_address varchar(120),
  event_description VARCHAR(200),
  event_finished BOOLEAN,
  PRIMARY KEY (event_id)
);



-- -------------------------------------------------------------------
-- Beginning of the sport table stat package relationships
-- Updates: can be associated with stats
-- Tags: can be given to certain stats
--   -Will define the stat specifics
--     -State meet, tennis tournament,
-- Tables relating to stats and the sport tables they correspond to

-- We should never have
CREATE TABLE stats(
  stat_id int(7) NOT NULL AUTO_INCREMENT,
  -- stats are associated with events
  event_id int(7),
  -- stats should really only be coming from one type of sport
  sport_id int(3),
  -- time this stat was sent into the database
  stat_timestamp TIMESTAMP,
  PRIMARY KEY (stat_id),
  FOREIGN KEY (event_id) REFERENCES tags(tag_id),
  FOREIGN KEY (sport_id) REFERENCES tags(tag_id)
);

-- SPORT: TRACK AND FIELD
-- track stat table will hold stats about track
CREATE TABLE track_stats(
  stat_id int(8),
  stat_type_id int(4),
  heat int(2),
  -- will be unique to sport, run time, throw distance, jump height
  -- rank stat = -1 if invalid or not set
  rank_stat float(2),
  -- wind
  wind_speed FLOAT(2),
  attempt_number INT(1),
  maxAttempt INT(1),
  -- was this a legal attempt?
  valid BOOLEAN
);



-- USER social integration
-- Are comments updates for events?
-- Users can commit updates to the system
--  -Officials commit event stats
--  -Users can commit comments
--  -Those comments can create links to other tags
--  NOTICE: Can tags create authorizations?
--  NOTICE: Are players just tag types?
-- Users are automatically associated to comments, (1xM)

-- Updates can be posted at peoples profiles
-- Reports
--  -Possible functionalities:

CREATE TABLE reports(
  report_id INT(7) NOT NULL AUTO_INCREMENT,

  -- updates have certain texts associated with them
  -- ex: John Smith has scored first place in pole vault
  --   These can be auto generated from stats
  -- Title shown on update
  report_title VARCHAR(50),

  report_text VARCHAR(255),
  update_time TIMESTAMP,
  PRIMARY KEY (update_id)
);

-- Users have the ability to post reports to events

-- If user is an official...
--  SCORE REPORTING
--    -reports made to event will be stat updates
         -- must have linkage to report to stats

-- INGOING REPORTS
--   ie reports that users send in to events
CREATE TABLE user_report(
  user_id INT(7) NOT NULL,
  report_id INT(7) NOT NULL,
  FOREIGN KEY (report_id) REFERENCES report(report_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- OUTGOING REPORTS
--  ie reports that an event generates
--    outgoing reports will generated once a new ingoing report is submitted
--  NOTE: Will act as the sql anchor statement for getting current messages
CREATE TABLE report_user(
  report_id INT(7) NOT NULL,
  user_id INT(7) NOT NULL,
  FOREIGN KEY (report_id) REFERENCES reports(report_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- EVENT REPORTS
--   Details about this event will be posted/shared here
--   Creates event feed connection
CREATE TABLE reports_events(
  report_id INT(7) NOT NULL,
  event_id INT(7) NOT NULL,
  FOREIGN KEY (report_id) REFERENCES reports(report_id),
  FOREIGN KEY (event_id) REFERENCES events(event_id)
);


-- There can be any number of stats associated with an report
CREATE TABLE reports_stats(
  report_id INT(7) NOT NULL,
  stat_id INT(7) NOT NULL,
  FOREIGN KEY (report_id) REFERENCES reports(report_id),
  FOREIGN KEY (stat_id) REFERENCES stats(stat_id)
);

-- Report type relationship
-- -Reports could be perceptibly be of many types
CREATE TABLE report_type(
  report_id INT(7),
  report_type_id INT(2),
  FOREIGN KEY (report_id) REFERENCES reports(report_id),
  FOREIGN KEY (report_type_id) REFERENCES  reportTypes(report_type_id)
);

-- All the different possible report types
CREATE TABLE reportTypes(
  report_type_id INT(2) NOT NULL AUTO_INCREMENT,
  report_type_name CHAR(10),
  PRIMARY KEY (report_type_id),
  KEY report_type_name (report_type_name)
);

INSERT INTO reportTypes VALUES
  (NULL, 'score_report'),
  (NULL, 'schedule_change'),
  (NULL, 'event_start'),
  (NULL, 'event_end');




-- TAG CONTROL SECTION

-- Essentially a big collection of adjectives
CREATE TABLE tags(
  tag_id INT(4) NOT NULL AUTO_INCREMENT,
  tag_name CHAR(10),
  PRIMARY KEY (tag_id),
-- will speed up searching through tags if we index it
  KEY tag_name (tag_name)
);

-- Let's start to create some of the preliminary tags we know we'll have
INSERT INTO Sport_tags VALUES
-- Track and it's adjectives
  (null, 'Track'),
  (null, 'Running'),
  (null, 'Jumping'),
  (null, 'Throwing'),
  (null, 'Field'),
  (null,'100m Dash'),
  (null,'200m Dash'),
  (null,'400m Dash'),
  (null,'800m Dash'),
  (null,'1600m Dash'),
  (null,'200m Dash'),
  (null,'Long Jump'),
  (null,'Triple Jump'),
  (null,'High Jump'),
  (null,'Pole Vault'),
  (null,'Shot Put'),
  (null,'Discus'),
  (null,'Javelin');

-- Creates the relational matrix between tags and relations
-- tag_a is tagged by tag_b
-- ie tag b modifies tag b
-- 100mDash->running->track->isEvent
-- 100mDash is a running event
CREATE TABLE tag_tag(
  tag_id_a INT(4) NOT NULL,
  tag_id_b INT(4) NOT NULL,
  FOREIGN KEY (tag_id_a) REFERENCES tags(tag_id),
  FOREIGN KEY (tag_id_b) REFERENCES tags(tag_id)
);
