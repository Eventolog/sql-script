# Eventology SQL Script

This repository contains the SQL script for setting up the **Eventology** database. **Eventology** is a platform designed to manage cultural events, venue reservations, ticketing, communications, and incidents efficiently.

### Database Structure

The SQL script creates the database and sets up the following tables:

- **users**: Stores information about system users (admins, organizers, attendees).
- **rooms**: Stores details of the event venues, including capacity and descriptions.
- **chatrooms**: Manages private chat sessions between users.
- **messages**: Stores individual messages exchanged in chatrooms.
- **events**: Stores information about events, including scheduling, organizers, and assigned venues.
- **seats**: Manages seating arrangements within venues.
- **inventory_items**: Stores inventory details for event venues.
- **media**: Stores multimedia files related to events.
- **tickets**: Manages ticket reservations, linking them to users, events, and seating.
- **incidences**: Tracks reported issues related to tickets and events, including resolution status.
- **incidences_tickets**: Links reported incidences with specific tickets.
- **inventory_rooms**: Associates inventory items with specific rooms and their quantities.

### Entity-Relationship Model

For a visual representation of the database structure, you can view the **Entity-Relationship (ER)** model and **Relational model** at the following link:  
[View ER and Relational Models](https://docs.google.com/document/d/17YsqK0R4VNMJzbZlO_tBeqZVTF1UxyMFWHSOEDKiqRA/edit?usp=sharing)

### Usage

1. Run the script to create the **eventology** database and all necessary tables.
2. Populate the tables with initial data as required.
3. Use the database to efficiently manage users, events, reservations, messaging, and incident reporting for the platform.