package com.infrasofttech.eco_mfi;//This program can be used to convert a number to words

import java.util.*;

class NumberToWordsConverter {
    private static final String EMPTY = "";

    //[,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    private static final String[] W =
            {
                    EMPTY, "Tokkoo ", "Lamaa ", "Sadii ", "Afurii ", "Shanii ", "Jahaa ",
                    "Torbaa ", "Saddeetii ", "Sagalii ", "Kudhanii ", "Kudha Tokkoo ", "Kudha Lamaa ",
                    "Kudha Sadii ", "Kudha Afurii ", "Kudha Shanii ", "Kudha Jahaa ",
                    "Kudha Torbaa ", "Kudha Saddeetii  ", "Kudha Sagalii  "
            };


    //[,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    private static final String[] X =
            {
                    EMPTY, "Tokko ", "Lama ", "Sadi ", "Afur ", "Shan ", "Jaha ",
                    "Torba ", "Saddeet ", "Sagal ", "Kudhan ", "Kudha Tokko ", "Kudha Lama ",
                    "Kudha Sadi ", "Kudha Afur ", "Kudha Shan ", "Kudha Jaha ",
                    "Kudha Torba ", "Kudha Saddeet  ", "Kudha Sagal  "
            };
    // [10,20,30,40,50,60,70,80,90]
    private static final String[] Y =
            {
                    EMPTY, EMPTY, "Digdama ", "Soddoma ", "Afurtama ", "Shantama ",
                    "Jaatama ", "Torbaatama ", "Saddeettama ", "Sagaltama "
            };

    // [10,20,30,40,50,60,70,80,90]
    private static final String[] Z =
            {
                    EMPTY, EMPTY, "Digdamii ", "Soddomii ", "Afurtamii ", "Shantamii ",
                    "Jaatamii ", "Torbaatamii ", "Saddeettamii ", "Sagaltamii "
            };

    private static String convertToDigit(int n, String suffix) {
        if (n == 0) {
            return EMPTY;
        }


        if (suffix.isEmpty()){
            if (n > 19 && n <= 99) {
                if (n % 10 == 0)
                    return suffix + Y[n / 10] + X[n % 10];
                else
                    return suffix + Z[n / 10] + X[n % 10];
            } else if (n < 20) {
                return suffix + X[n];
            } else if (n > 99){
                return suffix + Y[n / 10] + X[n % 10];
            }

        } else {
            if (n > 19 && n <= 99) {
                if (n % 10 == 0)
                    return suffix + Y[n / 10] + W[n % 10];
                else
                    return suffix + Z[n / 10] + W[n % 10] + "fi "
                            ;
            } else if (n < 20) {
                return suffix + W[n] + "fi ";
            } else if (n > 99){
                return suffix + Y[n / 10] + W[n % 10];
            }

        }




        return  EMPTY;
    }

    public static String convert(int n) {
        StringBuilder res = new StringBuilder();

        res.append(convertToDigit(((n / 1000000) % 100), "miiliyoona, "));

        res.append(convertToDigit(((n / 100000) % 100), "Kuma Dhibba, "));

        res.append(convertToDigit(((n / 1000) % 100), "Kuma "));

        res.append(convertToDigit(((n / 100) % 10), "Dhibba "));

        /*if ((n > 99)) {
            res.append("fi ");
        }*/

        res.append(convertToDigit((n % 100), ""));

        return res.toString();
    }

    public static void main(String[] args) {
        int n;
        System.out.println("\nEnter a number: ");
        Scanner sc = new Scanner(System.in);
        n = sc.nextInt();
        System.out.println(convert(n));

    }
}