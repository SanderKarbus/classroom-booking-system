from db import get_connection

def list_bookings():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM booking;")
    rows = cur.fetchall()

    print("\n--- BOOKINGS ---")
    for row in rows:
        print(row)

    conn.close()


def add_booking():
    classroom_id = input("Classroom ID: ")
    user_id = input("User/Group ID: ")
    lesson_type_id = input("Lesson Type ID: ")
    booking_date = input("Date (YYYY-MM-DD): ")
    start_time = input("Start time (HH:MM): ")
    end_time = input("End time (HH:MM): ")
    participants = input("Participants: ")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO booking
        (classroom_id, user_or_group_id, lesson_type_id,
         booking_date, start_time, end_time, participants)
        VALUES (%s,%s,%s,%s,%s,%s,%s);
    """, (classroom_id, user_id, lesson_type_id,
          booking_date, start_time, end_time, participants))

    conn.commit()
    conn.close()
    print("Booking added successfully.")


def update_booking():
    booking_id = input("Booking ID to update: ")
    new_participants = input("New participants count: ")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        UPDATE booking
        SET participants = %s
        WHERE id = %s;
    """, (new_participants, booking_id))

    conn.commit()
    conn.close()
    print("Booking updated.")


def delete_booking():
    booking_id = input("Booking ID to delete: ")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("DELETE FROM booking WHERE id = %s;", (booking_id,))

    conn.commit()
    conn.close()
    print("Booking deleted.")


def show_statistics():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT * FROM classroom_usage_hours;")
    rows = cur.fetchall()

    print("\n--- CLASSROOM USAGE HOURS ---")
    for row in rows:
        print(row)

    conn.close()


def main():
    while True:
        print("\n==== CLASSROOM BOOKING APP ====")
        print("1. List bookings")
        print("2. Add booking")
        print("3. Update booking")
        print("4. Delete booking")
        print("5. Show statistics")
        print("0. Exit")

        choice = input("Select option: ")

        if choice == "1":
            list_bookings()
        elif choice == "2":
            add_booking()
        elif choice == "3":
            update_booking()
        elif choice == "4":
            delete_booking()
        elif choice == "5":
            show_statistics()
        elif choice == "0":
            break
        else:
            print("Invalid option.")


if __name__ == "__main__":
    main()
