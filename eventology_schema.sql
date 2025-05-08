DROP DATABASE IF EXISTS eventology;
CREATE DATABASE eventology;
GO

USE eventology;
GO

CREATE TABLE users (
    id INT IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    type NVARCHAR(20) CHECK (type IN ('normal', 'organizer', 'superadmin')),
    CONSTRAINT pk_users PRIMARY KEY (id)
);

CREATE TABLE rooms (
    id INT IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    capacity INT CHECK (capacity > 0),
	hasSeatingDistribution BIT NOT NULL,
	roomLayout NVARCHAR(MAX) NOT NULL,
	deleted BIT DEFAULT 0,
    description NVARCHAR(500),
    CONSTRAINT pk_rooms PRIMARY KEY (id)
);

CREATE TABLE inventory_items (
    id INT IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    CONSTRAINT pk_inventory_items PRIMARY KEY (id)
);

CREATE TABLE chatrooms (
    id INT IDENTITY(1,1),
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    CONSTRAINT pk_chatrooms PRIMARY KEY (id),
    CONSTRAINT fk_chatrooms_user1 FOREIGN KEY(user1_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_chatrooms_user2 FOREIGN KEY(user2_id) REFERENCES users (id)
);

CREATE TABLE messages (
    id INT IDENTITY(1,1),
    content NVARCHAR(MAX) NOT NULL,
    date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('sent', 'delivered', 'read')),
    sender_id INT NOT NULL,
    chat_id INT NOT NULL,
    CONSTRAINT pk_messages PRIMARY KEY (id),
    CONSTRAINT fk_messages_sender FOREIGN KEY(sender_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_messages_chat FOREIGN KEY(chat_id) REFERENCES chatrooms (id)
);

CREATE TABLE events (
    id INT IDENTITY(1,1),
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    if_full_day BIT DEFAULT 0,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('scheduled', 'cancelled', 'completed')),
    created_at DATETIME DEFAULT GETDATE(),
    organizer_id INT NOT NULL,
    room_id INT NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (id),
    CONSTRAINT fk_events_organizer FOREIGN KEY(organizer_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_events_room FOREIGN KEY(room_id) REFERENCES rooms (id) ON DELETE CASCADE
);

CREATE TABLE seats (
    id INT IDENTITY(1,1),
    row_number INT NOT NULL,
    seat_number INT NOT NULL,
    room_id INT NOT NULL,
    CONSTRAINT pk_seats PRIMARY KEY (id),
    CONSTRAINT fk_seats_room FOREIGN KEY(room_id) REFERENCES rooms (id) ON DELETE CASCADE
);

CREATE TABLE media (
    id INT IDENTITY(1,1),
    path NVARCHAR(255) NOT NULL,
    event_id INT NOT NULL,
    CONSTRAINT pk_media PRIMARY KEY (id),
    CONSTRAINT fk_media_event FOREIGN KEY(event_id) REFERENCES events (id) ON DELETE CASCADE
);

CREATE TABLE tickets (
    id INT IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    reservation DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('reserved', 'cancelled', 'used')),
    buyer_id INT NOT NULL,
    event_id INT NOT NULL,
    seat_id INT NULL,
    CONSTRAINT pk_tickets PRIMARY KEY (id),
    CONSTRAINT fk_tickets_buyer FOREIGN KEY(buyer_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_tickets_event FOREIGN KEY(event_id) REFERENCES events (id),
    CONSTRAINT fk_tickets_seat FOREIGN KEY(seat_id) REFERENCES seats (id) ON DELETE CASCADE
);

CREATE TABLE incidences (
    id INT IDENTITY(1,1),
    reason NVARCHAR(500) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('open', 'in_progress', 'closed')),
    normal_user_id INT NOT NULL,
    solver_user_id INT NOT NULL,
    CONSTRAINT pk_incidences PRIMARY KEY (id),
    CONSTRAINT fk_incidences_normal_user FOREIGN KEY(normal_user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_incidences_solver_user FOREIGN KEY(solver_user_id) REFERENCES users (id)
);

CREATE TABLE incidences_tickets (
    ticket_id INT NOT NULL,
    incidence_id INT NOT NULL,
    CONSTRAINT pk_incidences_tickets PRIMARY KEY (ticket_id, incidence_id),
    CONSTRAINT fk_tickets_incidences FOREIGN KEY(ticket_id) REFERENCES tickets (id) ON DELETE CASCADE,
    CONSTRAINT fk_incidences_tickets FOREIGN KEY(incidence_id) REFERENCES incidences (id)
);

CREATE TABLE inventory_rooms (
    room_id INT NOT NULL,
    inventory_id INT NOT NULL,
    quantity INT CHECK (quantity >= 0),
    CONSTRAINT pk_inventory_rooms PRIMARY KEY (room_id, inventory_id),
    CONSTRAINT fk_inventory_rooms FOREIGN KEY(room_id) REFERENCES rooms (id) ON DELETE CASCADE,
    CONSTRAINT fk_rooms_inventory FOREIGN KEY(inventory_id) REFERENCES inventory_items (id) ON DELETE CASCADE
);
