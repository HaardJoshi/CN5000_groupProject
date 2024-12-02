-- ===========================
--         QUERY: 1
-- ===========================
SELECT CLASS_TYPE AS CLASS_LIST,
(SELECT FIRST_NAME ||' '|| LAST_NAME FROM STAFF WHERE STAFF_ID = FITNESS_CLASSES.INSTRUCTOR_ID) AS INSTRUCTOR_NAME, 
TO_CHAR(SCHEDULE,'DD-MON-YYYY HH24:MI') AS SCHEDULE
FROM FITNESS_CLASSES
ORDER BY CLASS_LIST;

-- ===========================
--         QUERY: 2
-- ===========================

SELECT CLIENTS.FIRST_NAME || ' ' || CLIENTS.LAST_NAME AS CLIENT_NAME, CLASS_BOOKINGS.STATUS
FROM FITNESS_CLASSES
JOIN CLASS_BOOKINGS ON FITNESS_CLASSES.CLASS_ID = CLASS_BOOKINGS.CLASS_ID
JOIN CLIENTS ON CLASS_BOOKINGS.CLIENT_ID = CLIENTS.CLIENT_ID
WHERE FITNESS_CLASSES.CLASS_TYPE = 'Yoga';

-- ===========================
--         QUERY: 3
-- ===========================

SELECT 
    SUM(CASE WHEN SERVICE_NAME = 'Membership' THEN AMOUNT ELSE 0 END) AS MEMBERSHIP_REVENUE,
    SUM(CASE WHEN SERVICE_NAME = 'Class Booking' THEN AMOUNT ELSE 0 END) AS CLASS_REVENUE,
    SUM(CASE WHEN SERVICE_NAME = 'Personal Training' THEN AMOUNT ELSE 0 END) AS PST_REVENUE,
    SUM(CASE WHEN SERVICE_NAME IN ('Membership', 'Class Booking', 'Personal Training') THEN AMOUNT ELSE 0 END) AS TOTAL_REVENUE
FROM BILLING;

-- ===========================
--         QUERY: 4
-- ===========================
SELECT PTS.TRAINER_ID, ST.FIRST_NAME || ' ' || ST.LAST_NAME AS TRAINER_NAME, COUNT(PTS.TRAINING_ID) AS SESSIONS_TAKEN
FROM PERSONAL_TRAINING_SESSIONS PTS
JOIN STAFF ST
ON PTS.TRAINER_ID = ST.STAFF_ID
GROUP BY PTS.TRAINER_ID, ST.FIRST_NAME, ST.LAST_NAME
ORDER BY SESSIONS_TAKEN DESC, TRAINER_NAME
FETCH FIRST 5 ROWS ONLY;

-- ===========================
--         QUERY: 5
-- ===========================

SELECT 
    CL.FIRST_NAME || ' ' || CL.LAST_NAME AS CLIENT_NAME,
    CL.CLIENT_ID,
    COUNT(GA.ATTENDANCE_ID) AS CHECKIN_COUNT
FROM GYM_ATTENDANCE GA
JOIN MEMBERSHIP MEM ON GA.CLIENT_ID = MEM.CLIENT_ID
JOIN CLIENTS CL ON GA.CLIENT_ID = CL.CLIENT_ID
WHERE MEM.END_DATE < SYSDATE -- Membership has expired
  AND GA.CHECK_IN > SYSDATE - 30 -- Checked in within the last 30 days
GROUP BY CL.FIRST_NAME, CL.LAST_NAME, CL.CLIENT_ID
ORDER BY CLIENT_NAME;

-- ===========================
--         QUERY: 6
-- ===========================

SELECT CL.FIRST_NAME || ' ' || CL.LAST_NAME AS CLIENT_NAME, COUNT(PTS.EXERCISE_TYPE) AS EXERCISES
FROM PERSONAL_TRAINING_SESSIONS PTS
JOIN CLIENTS CL ON PTS.CLIENT_ID = CL.CLIENT_ID
WHERE CL.CLIENT_CATEGORY = 'Member'
GROUP BY CL.FIRST_NAME, CL.LAST_NAME
-- using 'HAVING' function instead of 'WHERE' as group by does not support 'WHERE'
HAVING COUNT(PTS.EXERCISE_TYPE) >= 3
ORDER BY EXERCISES DESC, CLIENT_NAME;

-- ===========================
--         QUERY: 7
-- ===========================

SELECT DISCOUNT_CODE, USAGE_COUNT, REVENUE_LOSS
FROM DISCOUNTS
ORDER BY REVENUE_LOSS;

-- ===========================
--         QUERY: 8
-- ===========================

SELECT 
    -- link the first and last names of the client to display the full name
    CL.FIRST_NAME || ' ' || CL.LAST_NAME AS CLIENT_NAME,
    
    -- Number of gym visits in the last 30 days; if null, show as 0
    NVL(CUR.GYM_VISITS, 0) AS GYM_VISITS,
    
    -- Calculate progress percentage towards the goal of 21 visits in the last 30 days,
    -- cap the result at 100%
    TRUNC(LEAST(NVL(100 * (CUR.GYM_VISITS / 21), 0), 100)) || '%' AS PROGRESS,
    
    -- Number of gym visits in the previous 31–60 days; if null, show as 0
    NVL(LAST.GYM_VISITS, 0) AS LAST_MONTH_GYM_VISITS,
    
    -- Calculate progress percentage for 31–60 days ago, cap at 100%, and format with a '%'
    TRUNC(LEAST(NVL(100 * (LAST.GYM_VISITS / 21), 0), 100)) || '%' AS LAST_MONTH_PROGRESS,
    
    -- List of visit dates in the last 30 days; if null, display 'No Visits'
    NVL(CUR.VISIT_DATES, 'No Visits') AS VISIT_DATES
FROM CLIENTS CL
-- Join with a subquery that calculates gym visits and visit dates for the last 30 days
LEFT JOIN (
    SELECT 
        GA.CLIENT_ID, -- Group by client ID
        COUNT(*) AS GYM_VISITS, -- Count the number of visits
        -- Create a comma-separated list of visit dates, formatted as DD-MM-YYYY
        LISTAGG(TO_CHAR(GA.CHECK_IN, 'DD-MM-YYYY'), ', ') WITHIN GROUP (ORDER BY GA.CHECK_IN) AS VISIT_DATES
    FROM GYM_ATTENDANCE GA
    WHERE GA.CHECK_IN >= SYSDATE - 30 -- Only consider visits in the last 30 days
    GROUP BY GA.CLIENT_ID -- Group by client ID to summarize visits per client
) CUR ON CL.CLIENT_ID = CUR.CLIENT_ID -- Match the client ID to join with the CLIENTS table

-- Join with another subquery that calculates gym visits for 31–60 days ago
LEFT JOIN (
    SELECT 
        GA.CLIENT_ID, -- Group by client ID
        COUNT(*) AS GYM_VISITS -- Count the number of visits in the specified time range
    FROM GYM_ATTENDANCE GA
    WHERE GA.CHECK_IN BETWEEN SYSDATE - 60 AND SYSDATE - 31 -- Time range: 31–60 days ago
    GROUP BY GA.CLIENT_ID -- Group by client ID to summarize visits per client
) LAST ON CL.CLIENT_ID = LAST.CLIENT_ID -- Match the client ID to join with the CLIENTS table;
