USE eventology;

-- USERS
INSERT INTO users (name, email, password, type) VALUES
('Alice Smith', 'alice@example.com', 'password123', 'normal'),
('org', 'org@ev.com', 'org', 'organizer'),
('root', 'root@ev.com', 'root', 'superadmin');

-- Sala amb layout (JSON)
DECLARE @layout NVARCHAR(MAX) = N'{
  "Scenery": [{"Type": "Scenery", "Bounds": "0, 0, 400, 50"}],
  "Seats": [
    {"Bounds": "13, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 1},
    {"Bounds": "53, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 2},
    {"Bounds": "53, 123, 30, 30", "Price": 0.0, "Row": 2, "SeatNumber": 2},
    {"Bounds": "13, 123, 30, 30", "Price": 0.0, "Row": 2, "SeatNumber": 1},
    {"Bounds": "93, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 3},
    {"Bounds": "134, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 4},
    {"Bounds": "232, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 5},
    {"Bounds": "274, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 6},
    {"Bounds": "315, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 7},
    {"Bounds": "356, 74, 30, 30", "Price": 0.0, "Row": 1, "SeatNumber": 8}
  ]
}';

-- ROOMS (Afegim la tercera que faltava)
INSERT INTO rooms (name, capacity, description, hasSeatingDistribution, roomLayout) VALUES
('Empty Room', 200, 'Large empty room', 0, ''),
('Room with seats', 6, 'Small meeting room', 1, @layout),
('Outdoor Area', 300, 'Concert space', 0, '');

-- INVENTORY_ITEMS
INSERT INTO inventory_items (name, description) VALUES
('Projector', 'HDMI projector'),
('Microphone', 'Wireless microphone'),
('Whiteboard', 'Large whiteboard with markers');

-- CHATROOMS
INSERT INTO chatrooms (user1_id, user2_id) VALUES
(1, 2),
(2, 3),
(1, 3);

-- MESSAGES
INSERT INTO messages (content, status, sender_id, chat_id) VALUES
('Hello Bob!', 'sent', 1, 1),
('Hey Charlie, how are you?', 'delivered', 2, 2),
('Meeting at 3 PM', 'read', 1, 3);

-- EVENTS (referenciem sales 1, 2 i 3 que ara existeixen)
INSERT INTO events (name, description, if_full_day, start_time, end_time, status, organizer_id, room_id) VALUES
('Tech Conference', 'Annual technology conference', 0, '2025-06-01 09:00:00', '2025-06-01 18:00:00', 'scheduled', 2, 1),
('Startup Pitch', 'Pitch your startup ideas', 0, '2025-06-10 10:00:00', '2025-06-10 13:00:00', 'scheduled', 2, 2),
('Music Festival', 'Outdoor music festival', 1, '2025-07-15 00:00:00', '2025-07-15 23:59:00', 'scheduled', 2, 3);

-- SEATS
INSERT INTO seats (row_number, seat_number, room_id) VALUES
(1, 1, 2),
(1, 2, 2),
(1, 3, 2);

-- MEDIA
INSERT INTO media (path, event_id) VALUES
('/media/tech_conference_banner.jpg', 1),
('/media/startup_pitch_poster.jpg', 2),
('/media/music_festival_poster.jpg', 3);

-- TICKETS
INSERT INTO tickets (name, reservation, status, buyer_id, event_id, seat_id) VALUES
('Ticket 1', GETDATE(), 'reserved', 1, 1, 1),
('Ticket 2', GETDATE(), 'reserved', 2, 2, 2),
('Ticket 3', GETDATE(), 'reserved', 1, 3, 3);

-- INCIDENCES
INSERT INTO incidences (reason, status, normal_user_id, solver_user_id) VALUES
('Projector not working', 'open', 1, 3),
('Room too cold', 'in_progress', 2, 3),
('Microphone missing', 'closed', 1, 3);

-- INCIDENCES_TICKETS
INSERT INTO incidences_tickets (ticket_id, incidence_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- INVENTORY_ROOMS
INSERT INTO inventory_rooms (room_id, inventory_id, quantity) VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 1);
