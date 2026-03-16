# room_booking

1. How to handle the situation where two different people 
    try to book the same room at the same time

2. User Profile, how to have custom fields with devise?

3. Edit booking time after booking has been created, if overlapping bookings 
    then request the other user with whom the time is overlapping to change

    like "Hey can you schedule your booking at 3:30 mine is getting extended"

    Request will not propogate to other users, once accepted, if rejected then user
    can send edit request to other user

4. Normal User can only see current bookings, name, mobile number of user 
    who has booked the room

5. Admin can see all bookings, rooms & users CRUD, Cancel (don't delete booking directly)
    any user's booking, basically override, Admin's action cannot be over-ruled by normal user

6. Rspec

IMPORTANT

7. STANDARD SLOTTING 15 min slot, 1 hour has 4 slots 9 hours 
    will have 32 slots proper slotting
    ensures that room is not wasted, saturday sunday no booking

8. Booking must be cancelled not deleted

9. It is used for further analytics
