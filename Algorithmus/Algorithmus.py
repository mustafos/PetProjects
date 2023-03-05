# Data Structure & Algorithmus

###Searching Algorithms
def array_search(A:list, N:int, x:int):
    """Searches for the number X in the array A from 0 to N-1 index inclusive.  
       Returns the index of element X in array A. Or -1 if there is none.
       If there are several identical elements in the array equal to X, 
       then return the index of the first one in the count.
    """
    for k in range(N):
        if A[k] == x:
            return k
        return -1

def test_array_search():
    A1 = [1, 2, 3, 4, 5]
    m = array_search(A1, 5, 8)

###Sorted Algorithmus
def insert_sort(A):
    """ sorting list A by inserts """
    N = len(A)
    for top in range(1, N):
        k = top
        while k > 0 and A[k-1] > A[k]:
            A[k], A[k-1] = A[k-1], A[k]
            k -= 1

def choise_sort(A):
    """sorting list A by choice"""
    N = len(A)
    for pos in range(0, N-1):
        for k in range(pos+1, N):
            if A[k] < A[pos]:
                A[k], A[pos] = A[pos], A[k]

def bubble_sort(A):
    """sorting list A by bubble method"""
    N = len(A)
    for bypass in range(1, N):
        for k in range(0, N-bypass):
            if A[k] > A[k+1]:
                A[k], A[k+1] = A[k+1], A[k]

def test_sort(sort_algorithm):
    print("Testing: ", sort_algorithm.__doc__)
    print("testcase #1: ", end="")
    A = [4, 2, 5, 1, 3]
    A_sorted = [1, 2, 3, 4, 5]
    sort_algorithm(A)
    print("OK" if A == A_sorted else "FAIL")

    print("testcase #2: ", end="")
    A = list(range(10, 20)) + list(range(0, 10))
    A_sorted = list(range(20))
    sort_algorithm(A)
    print("OK" if A == A_sorted else "FAIL")

    print("testcase #3: ", end="")
    A = [4, 2, 4, 2, 1]
    A_sorted = [1, 2, 2, 4, 4]
    sort_algorithm(A)
    print("OK" if A == A_sorted else "FAIL")

if __name__ == "__main__":
    test_sort(insert_sort)
    test_sort(choise_sort)
    test_sort(bubble_sort)

###Recursion
def droste(n):
    if n == 1:
        print("Droste effect")
    else:
        print("Up droste n=", n)
        droste(n-1)
        print("Down droste n=", n)

droste(5)

def factorial(n):
    assert n >= 0, """factorial of negative is not defined"""
    if n == 0:
        return 1
    return factorial(n - 1) * n

def gcd(a, b):
    return a if b == 0 else gcd(b, a % b)

def pow(a, n):
    if n == 0:
        return 1
    elif n % 2 == 1: #odd 
        return pow(a, n - 1) * a
    else: #even
        return pow(a**2, n // 2)