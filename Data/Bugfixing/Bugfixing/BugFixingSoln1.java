package Bugfixing;

import java.util.Arrays;

public class BugFixingSoln1 {

	//return the character that occurs the most frequently in the given string
    //in case of more than one character satisfying the requirement, we need to
    //return the earliest character alphabetically
    
	String solution(String S) {
        int[] occurrences = new int[26];
        
        S=S.toLowerCase();                                 // to avoid conflict of Upper and lower case
        S=S.replaceAll(" ","");                                      // to avoid error that might be encountered when a string with white space is inputed 
        if(S.isEmpty())                                              // return message String Empty if string is empty.
        	return "String Empty";
        
        for (char ch : S.toCharArray()) {
            occurrences[ch - 'a']++;
        	
        }
       
        char best_char = 'a';
        int best_res = 0;
        for (int i = 0; i < 26; i++) {								 // i will start from 0 instead of 1 to take all characters. 
//            if (occurrences[i] >= best_res) {                      // as we have to return highest occurrence alphabetically it should be > only
        		if (occurrences[i] > best_res) {
                best_char = (char)((int) 'a' + i);
                best_res = occurrences[i];
              
            }
        }

 

        return Character.toString(best_char);
    }
    
    public static void main(String[] args) {
        System.out.println(new BugFixingSoln1().solution("hello")); // function can be static instead of calling it using class object
    }

}
