(*Juan Olivo CS235*)

(*Returns Older Date*)
fun is_older (d1 : int*int*int , d2 : int*int*int) = if #3 d1 < #3 d2 then (*First check Year*)
                                true
                                  else if #3 d1 = #3 d2 andalso (#1 d1 < #1 d2) then (*then Month*)
                                        true
                                       else if #3 d1 = #3 d2 andalso (#1 d1 < #1 d2) andalso #2 d1 < #2 d2 then  
                                          true
                                          else false;

 



fun number_in_month (xs : (int*int*int) list, d) = if null xs then (*make sure list of dates isn't empty*)
                                                  0           (*if it is return 0*)
                                                 else 
                                                 if #2 (hd xs) = d       (*if same month *)
                                                    then 1 + number_in_month(tl xs, d) (*return 1 and call number_in_month again with rest of list*)
                                                    else 0 + number_in_month(tl xs, d); (*else just call number_in_month with rest of list*)


fun number_in_months (xs : (int*int*int) list, d : int list) = if null d then (*if list of months is empty return 0*)
                                                           0
                                                         else 
                                                          number_in_month(xs, hd d) + number_in_months(xs, tl d); (* else call number_in_month on first element of list of months, + rest of xs on number_in_months*)




fun dates_in_month (xs : (int*int*int) list, d) = if null xs then (*if list of dates is empty, return empty list*)
                                                  []
                                                 else 
                                                 if #2 (hd xs) = d    (*Else Append all dates in the month into one list untill its gone through the whole list*)
                                                    then hd xs :: dates_in_month(tl xs, d)
                                                    else dates_in_month(tl xs, d); 


fun dates_in_months (xs : (int*int*int) list, d : int list) = if null d then (*if list of dates is empty, return empty list*)
                                                  []
                                                 else 
                                                    dates_in_month(xs, hd d) @ dates_in_months(xs, tl d);  (* else call dates_in_month on first element of xs, cons to rest of xs on datein_months*)



fun get_nth (sl : string list, nth) = if nth = 1 then         (*if nth = 1 then return the front of string list*)
                                                 hd sl
                                                 else 
                                                 get_nth (tl sl, nth -1); (* else call get nth with rest of sl, and decrease nth by 1 until nth = 1*)




(*Use get nth to get correct month, and intoString to get the correct day and year and combine all with *)
fun date_to_string (d : int*int*int) = get_nth(["Jannuary","Febuary","March","April","May","June",
                                       "July","August","September","October","November","December"], (#2 d)) 
                                       ^"-"^(Int.toString (#1 d))^"-"^(Int.toString (#3 d));


fun number_before_reaching_sum (sum : int, l : int list) = if (sum - hd l) <= 0 then (*if sum minus first num in the list is less than zero then return 0*)
                                                                 0
                                                                else                 (*Else keep adding one, and recalling the function with sum minus the hd of list until sum is less than 1*)
                                                                 1 + number_before_reaching_sum(sum-(hd l), tl l);


(*Use prev funct to get corresct numbered month, then use get_nth with the # of month and a list of months in string to get the correct month in string*)
fun what_month (day : int) = get_nth(["January","Febuary","March","April","May","June",
                                       "July","August","September","October","November","December"], 
                                       number_before_reaching_sum (day, [31,28,31,30,31,30,31,31,30,31,30,31])+1);


(*Keep adding dates into a list and re calling month_range with day1 + 1 untill day2 > day2 *)
fun month_range (day1 : int, day2 : int) = if day1 > day2 then
                                              []
                                              else 
                                              what_month(day1) :: month_range(day1 + 1, day2);

fun oldest(dates : (int * int * int) list ) = if null dates 
                                               then NONE
                                               else
                                               (*Oldest_nonempty1 tests one date vs all other dates and returs true if it is older than the rest*)
                                                 let fun oldest_nonempty1(dates : (int * int * int) list, date : (int * int * int)) =
                                                 if null dates
                                                     then true
                                                     else 
                                              if is_older(date, hd dates)
                                                 then oldest_nonempty1(tl dates, date)
                                                 else false
                                                 (*oldest_nonempty2 calls oldest_nonempty1 with hd vs tl untill it finds the oldest date then returns that*)
                                               fun oldest_nonempty2(dates : (int * int * int) list) = 
                                               if oldest_nonempty1(tl dates, hd dates)
                                                 then hd dates
                                                 else oldest_nonempty2(tl dates)
                                              in
                                               (*Just returns the answer from oldest_nonempty2*)
                                               SOME (oldest_nonempty2(dates))
                                              end;
                                             


(*Helper function that takess val acc which will accumulate the sum of each value in the list and add it the the next element in the list*)
fun cumulative_sum_helper (lnum, acc) = if null lnum then
                                           []
                                           else 
                                           (acc + hd lnum) :: cumulative_sum_helper (tl lnum, acc + (hd lnum));



(*same as before but we set acc to always be zero so the func only takes one argument *)
fun cumulative_sum lnum : int list = cumulative_sum_helper (lnum, 0);




	
