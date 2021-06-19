SELECT   Driver.first_name, Driver.last_name, Destination.state,
SUM(Ride.paid_to_driver) AS paid_to_driver
FROM     Ride
JOIN     Driver ON Driver.driver_id = Ride.driver_id
JOIN     Destination ON Destination.destination_id = Ride.destination_id
GROUP BY Destination.state, Driver.driver_id, Driver.first_name, Driver.last_name
ORDER BY first_name, last_name, state;


SELECT   Driver.first_name, Driver.last_name, Destination.state,
SUM(Ride.paid_to_driver) AS paid_to_driver
FROM     Ride
JOIN     Driver ON Driver.driver_id = Ride.driver_id
JOIN     Destination ON Destination.destination_id = Ride.destination_id
GROUP BY ROLLUP(Destination.state), Driver.driver_id, Driver.first_name,
Driver.last_name
ORDER BY first_name, last_name, state;
