module Day14 where
  
import Numeric
import Data.Char (intToDigit)
import Day10p2 (knotHash) -- importing knot hash from day 10

-- convert a base 16 number to base 10
hexToDec :: Char -> Int 
hexToDec c = fst $ head $ readHex [c]

-- convert a number to its binary representation (4 chars)
toBinary :: Int -> String
toBinary val = reverse $ take 4 $ reverse $ "0000" ++ (showIntAtBase 2 intToDigit val "")

-- convert a list of numbers to the string generated by concatenating the binary representation of each value
toBinaryString :: String -> String
toBinaryString values = concat $ map toBinary $ map hexToDec values

countBits' :: String -> Int -> Int
countBits' _ 128 = 0
countBits' input row = 
  let
    rowInput = input ++ "-" ++ (show row)
    binaryHash = toBinaryString $ knotHash rowInput 
  in length (filter (== '1') binaryHash) + countBits' input (row+1)

countBits :: String -> Int
countBits input = countBits' input 0

solve :: String -> Int
solve input =  countBits input 