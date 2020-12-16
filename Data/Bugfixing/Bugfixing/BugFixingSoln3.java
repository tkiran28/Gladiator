package Bugfixing;

import java.util.Arrays;

public class BugFixingSoln3 {

	public boolean solution(int[] A, int K) {
		
		Arrays.sort(A);                                  //#1 In case given array is not sorted
		
		int n = A.length;
		for (int i = 0; i < n - 1 && A[i]<K; i++) {                 
			if (A[i] + 1 < A[i + 1])
				return false;
		}
		//if (A[0] != 1 && A[n - 1] != K)                //#2 It should return false if either of the condition fails 
		if (A[0] != 1 || A[n - 1] < K)	
			return false;
		else
			return true;
	}
	
	public static void main(String[] args) {
		int[] A = {1,2,2,2,3,5,5,6};
		int K = 3;
		System.out.println(new BugFixingSoln3().solution(A, K));
	}

}
