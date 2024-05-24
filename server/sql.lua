MySQL.query([[
    ALTER TABLE users ADD COLUMN IF NOT EXISTS steam VARCHAR(255) NOT NULL DEFAULT 'N/A',
    ADD COLUMN IF NOT EXISTS time INT DEFAULT 0;
]])

local table_exist = MySQL.query.await('SHOW TABLES LIKE ?', { 'ars_login' })

if #table_exist > 0 then return end


MySQL.query([[
    CREATE TABLE IF NOT EXISTS `ars_login` (
        `identifier` varchar(46) NOT NULL DEFAULT '',
        `pg` int(11) NOT NULL,
        PRIMARY KEY (`identifier`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
]])
