-- DROP DATABASE IF EXISTS WatchParty;
CREATE DATABASE IF NOT EXISTS WatchParty;

DROP TABLE IF EXISTS 
    'WatchParty'.'Friends', 
    'WatchParty'.'GroupRelationships'
    'WatchParty'.'Chats',
    'WatchParty'.'WatchLists',
    'WatchParty'.'Users',
    'WatchParty'.'Groups';

-- List of Users
CREATE TABLE IF NOT EXISTS 'WatchParty'.'Users' (
    UserId INT NOT NULL AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL,
    Passwrd VARCHAR(20) NOT NULL,
    PRIMARY KEY (UserID)
);

-- List of Groups
CREATE TABLE IF NOT EXISTS 'WatchParty'.'Groups' (
    GroupId INT NOT NULL AUTO_INCREMENT,
    Groupname VARCHAR(20) NOT NULL,
    PRIMARY KEY (GroupId)
);

-- Users and their associated groups
CREATE TABLE IF NOT EXISTS 'WatchParty'.'GroupRelationships' (
    UserId INT NOT NULL,
    GroupId INT NOT NULL,
    PRIMARY KEY (UserId, GroupId);
    FOREIGN KEY (UserId) REFERENCES 'WatchParty'.'Users'(UserId),
    FOREIGN KEY (GroupId) REFERENCES 'WatchParty'.'Groups'(GroupId),
);

-- Friend relationships between users
CREATE TABLE IF NOT EXISTS 'WatchParty'.'Friends' (
    UserIdA INT NOT NULL,
    UserIdB INT NOT NULL,
    -- Value : Meaning
    --------------------------------------------------
    -- None  : No Relationship
    -- 1     : UserA pending friendship from UserB
    -- 2     : UserB pending friendship from UserA
    -- 3     : UserA is friends with UserB
    -- 4     : UserA blocked UserB
    -- 5     : UserB blocked UserA
    -- 6     : UserA and UserB Blocked Eachother
    Relationship INT NOT NULL CHECK (Relationship >= 1 AND Relationship <= 6),
    CONSTRAINT CheckOrder CHECK (UserIdA < UserIdB),
    PRIMARY KEY (UserIdA, UserIdB),
    FOREIGN KEY (UserIdA) REFERENCES 'WatchParty'.'Users'(UserId),
    FOREIGN KEY (UserIdB) REFERENCES 'WatchParty'.'Users'(UserId)
);

-- Messages within a group between users
CREATE TABLE IF NOT EXISTS 'WatchParty'.'Chats' (
    ChatId INT NOT NULL,
    GroupId INT NOT NULL,
    SenderId INT NOT NULL,
    MessageText VARCHAR(250) NOT NULL,
    MessageTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ChatId),
    FOREIGN KEY (GroupId) REFERENCES 'WatchParty'.'Groups'(GroupId),
    FOREIGN KEY (SenderId) REFERENCES 'WatchParty'.'Users'(UserId)
);

-- Watchlists containing video names between users in a group
CREATE TABLE IF NOT EXISTS 'WatchParty'.'WatchLists' (
    WatchListId INT NOT NULL AUTO_INCREMENT,
    GroupId INT NOT NULL,
    WatchListItem VARCHAR(50) NOT NULL,
    PRIMARY KEY (WatchListId),
    FOREIGN KEY (GroupId) REFERENCES 'WatchParty'.'Groups'(GroupId) 
)
