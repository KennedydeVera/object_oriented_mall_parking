# README

Parking Allocation System

Welcome to the Parking Allocation System! This system is designed to manage parking slots and transactions for a parking facility. It allows users to allocate parking slots, track occupancy, and record parking transactions.
Features

    Parking Slot Management: Easily manage parking slots by size and availability.
    Vehicle Allocation: Allocate parking slots to vehicles based on size and availability.
    Transaction Recording: Record parking transactions including entry and exit times, vehicle details, and parking fees.
    Occupancy Tracking: Monitor parking slot occupancy in real-time.
    Fee Calculation: Automatically calculate parking fees based on duration and vehicle type.

Technologies Used

    Ruby on Rails: The backend framework used to develop the application.
    SQLite: The database management system used for data storage.
    HTML/CSS/JavaScript: Frontend technologies for user interface and interaction.
    Bootstrap: Frontend framework for responsive design and UI components.

Setup Instructions

To run the Parking Allocation System locally on your machine, follow these steps:

    Clone the Repository: Use Git to clone the repository to your local machine:

    bash

git clone https://github.com/KennedydeVera/object_oriented_mall_parking.git

Install Dependencies: Navigate to the project directory and install the necessary dependencies:

bash

cd object_oriented_mall_parking
bundle install

Database Setup: Migrate the database schema and seed initial data (if any):

bash

rails db:migrate

Start the Server: Start the Rails server to run the application:

    rails server

    Access the Application: Open your web browser and navigate to http://localhost:3000 to access the application.

Usage

    Allocating Parking Slots: To allocate a parking slot to a vehicle, navigate to the allocation page and enter the vehicle details (plate number and type). You will assign an available slot based on the vehicle type.
    Recording Exit: When a vehicle exits the parking facility, record the exit by providing the plate number and exit details. The system will calculate the parking fee and update the transaction records accordingly.
    Monitoring Occupancy: Use the dashboard to monitor parking slot occupancy and track available slots in real-time.

System Workflow

    Vehicle Entry
        User inputs vehicle plate number and selects vehicle type.
        System allocates a parking slot based on the vehicle type.
        Transaction details (plate number, slot ID, entry time) are logged.

    Vehicle Exit
        User inputs vehicle plate number and parking duration.
        System calculates parking fee based on the duration and vehicle type.
        Parking slot is freed up.
        Transaction details (plate number, exit time, parking fee) are logged.

    Parking Fee Calculation
        Parking fee is calculated based on the duration of parking and the vehicle type.
        Flat rate is applied for the first hour, with additional charges for exceeding hours and daily rates for long-term parking.

    Transaction Logging
        Each parking transaction is logged into the database.
        Transaction logs include plate number, slot ID, entry time, exit time, vehicle type, and parking fee.
