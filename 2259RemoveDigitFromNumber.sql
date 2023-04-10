-- 2259. Remove Digit From Number to Maximize Result
-- https://leetcode.com/contest/weekly-contest-291/problems/remove-digit-from-number-to-maximize-result/


/* 
You are given a string number representing a positive integer and a character digit.

Return the resulting string after removing exactly one occurrence of digit from number
 such that the value of the resulting string in decimal form is maximized. 
 The test cases are generated such that digit occurs at least once in number.

 

Example 1:

Input: number = "123", digit = "3"
Output: "12"
Explanation: There is only one '3' in "123". After removing '3', the result is "12".
Example 2:

Input: number = "1231", digit = "1"
Output: "231"
Explanation: We can remove the first '1' to get "231" or remove the second '1' to get "123".
Since 231 > 123, we return "231".
Example 3:

Input: number = "551", digit = "5"
Output: "51"
Explanation: We can remove either the first or second '5' from "551".
Both result in the string "51".
 

Constraints:

2 <= number.length <= 100
number consists of digits from '1' to '9'.
digit is a digit from '1' to '9'.
digit occurs at least once in number.

*/

/*
try all possible positions of the digit in the number,
remove it and compute the resulting decimal value of the new string. 
Then, return the string that maximizes the decimal value.
*/


WITH RECURSIVE 
digit_positions AS (
    SELECT 1 AS pos
    UNION ALL
    SELECT pos + 1
    FROM digit_positions
    WHERE pos <= LENGTH(number)),
    
number_variations AS (
    SELECT SUBSTRING(number, 1, pos - 1) || SUBSTRING(number, pos + 1) AS new_number
    FROM digit_positions
    WHERE SUBSTRING(number, pos, 1) = digit),

decimal_values AS (
    SELECT new_number, CAST(new_number AS INTEGER) AS decimal_value
    FROM number_variations
)

SELECT new_number
FROM decimal_values
WHERE decimal_value = (
    SELECT MAX(decimal_value)
    FROM decimal_values
);

-- generate all possible positions of the digit in the number, 
--generate the new variations of the number by removing the digit, 
--and compute the decimal value of each new number. 
--Finally, it selects the new number with the maximum decimal value

-- not an efficient one, but works
