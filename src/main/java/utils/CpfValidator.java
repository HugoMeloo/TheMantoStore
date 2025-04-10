package utils;

public class CpfValidator {
    public static boolean isValidCpf(String cpf) {
        cpf = cpf.replaceAll("[^0-9]", "");

        if (cpf.length() != 11 || cpf.matches("(\\d)\\1{10}")) {
            return false;
        }

        int sum = 0, remainder;
        for (int i = 0; i < 9; i++) {
            sum += Character.getNumericValue(cpf.charAt(i)) * (10 - i);
        }
        remainder = (sum * 10) % 11;
        if (remainder == 10) remainder = 0;
        if (remainder != Character.getNumericValue(cpf.charAt(9))) return false;

        sum = 0;
        for (int i = 0; i < 10; i++) {
            sum += Character.getNumericValue(cpf.charAt(i)) * (11 - i);
        }
        remainder = (sum * 10) % 11;
        if (remainder == 10) remainder = 0;
        return remainder == Character.getNumericValue(cpf.charAt(10));
    }
}
