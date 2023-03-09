# Data Structure & Algorithmus
""" Algorithms are essential to the way computers process data. Many computer programs contain algorithms that detail the specific instructions a computer should perform—in a specific order—to carry out a specified task, such as calculating employees' paychecks or printing students' report cards.
"""

###Searching Algorithms___________________________________________
def array_search(A:list, N:int, x:int):
    """ Searches for the number X in the array A from 0 to N-1 index inclusive.
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

###Binary Search_________________________________________________
def binary_search(list, item):
    low = 0
    high = len(list) - 1
    
    while low <= high:
        mid = (low + high) / 2
        guess = list[mid]
        if guess == item:
            return mid
        if guess > item:
            high = mid - 1
        else:
            low = mid + 1
    return None

###Sorted Algorithmus_____________________________________________
def findeSmallest(arr):
    smallest = arr[0]
    smallest_index = 0
    for i in range(1, len(arr)):
        if arr[i] < smallest:
            smallest = arr[i]
            smallest_index = i
    return smallest_index
    
def selectionSort(arr):
    newArr = []
    for i in range(len(arr)):
        smallest = findeSmallest(arr)
        newArr.append(arr.pop(smallest))
    return newArr
    
print(selectionSort([2, 5, 3, 8, 4, 6]))

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
    
def quicksort(array):
    if len(array) < 2:
        return array
    else:
        pivot = array[0]
        less = [i for i in array[1:] if i < pivot]
        
        greater = [i for i in array[1:] if i > pivot]
        
        return quicksort(less) + [pivot] + quicksort(greater)
print(quicksort([10, 5, 2, 3]))

def print_item(list):
    for item in list:
        print(item)

from time import sleep
def print_item2(item):
    for item in list:
        sleep(1)
        print(item)

###Recursion__________________________________________________
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
        
def look_for_key(box):
    for item in box:
        if item.is_a_box():
            look_for_key(item)
        elif item.is_a_key():
            print("found the key!")

def gen_bin(M, prefix=""):
    if M == 0:
        print(prefix)
        return
    for digit in "0", "1":
        gen_bin(M-1, prefix+digit)

def generate_number(N:int, M:int, prefix=None):
    """ Generates all numbers (with leading negligible zeros) 
        in N-numeral system of (N <= 10) length M
    """
    prefix = prefix or []
    if M == 0:
        print(prefix)
        return
    for digit in range(N):
        prefix.append(digit)
        generate_number(N, M-1, prefix)
        prefix.pop
#binary only
gen_bin(2)
#for arbitrary number system
generate_number(3, 2)

def find(number, A):
    """ searches for x in A and returns true 
    if there is a false, if there is no such
    """
    flag = False
    for x in A: 
        if number == x:
            flag = True
            break
    return flag

def generate_permutations(N:int, M:int=-1, prefix=None):
    """ Generation of all permutations of N numbers in M positions, 
        whith prefix
    """
    M = M if M != -1 else N # default N numbers in N positions
    prefix = prefix or []
    if M == 0:
        print(*prefix)
        return
    for number in range(1, N+1):
        if find(number, prefix): 
            continue
        prefix.append(number)
        generate_permutations(N, M-1, prefix)
        prefix.pop()

generate_permutations(3)

###Quick Sort__________________________________________________
def hoar_sort(A):
    if len(A) <= 1:
        return
    barrier = A[0]; L=[]; M=[]; R=[]
    for x in A:
        if x < barrier:
            L.append(x)
        elif x == barrier:
            M.append(x)
        else:
            R.append(x)
    hoar_sort(L)
    hoar_sort(R)
    k = 0
    for x in L + M + R:
        A[R] = x; k += 1

def check_sort(A, ascending = True):
    """ Sorting check by A """
    flag = True; s = 2 * int(ascending) - 1
    for i in range(0, s - 1):
        if A * A[i] > s * A[i + 1]:
            flag = False
            break
    return flag

###Dynamic programming__________________________________________
#Fibonacci sequence number
def fib(n):
    fib_num = [0, 1] + [0] * (n - 1)
    for i in range(2, n + 1):
        fib_num[i] = fib_num[i - 1] + fib_num[i - 2]
    return fib_num[n]
    
def count_trajectories(N, allowed: list):
    K = [0, 1, int(allowed[2])] + [None] * (N - 3)
    for i in range(3, N + 1):
        if allowed[i]:
            K[i] = K[i - 1] + K[i - 2] + K[i - 3]

def count_min_cost(N, price: list):
    C = [float("-inf"), price[1], price[1] + price[2]] + [0] * (N - 2)
    for i in range(3, N + 1):
        C[i] = price[i] + min(C[i - 1], C[i - 2])
    return C[N]

def traj_num(N):
    K = [0, 1] + [0] * N
    for i in range(2, N + 1):
        K[i] = K[i - 2] + K[i - 1]
    return K[N]

#Greatest common subsequence
def gcs(A, B):
    F = [[0] * (len(B) + 1) for i in range(len(A) + 1)]
    for i in range(1, len(A) + 1):
        for j in range(1, len(B) + 1):
            if A[i] == B[j]:
                F[i][j] = 1 + F[i - 1][j - 1]
            else:
                F[i][j] = max(F[i - 1][j], F[i][j - 1])
    return F[-1][-1]

#Greatest increasing subsequence
def gis(A):
    F = [0] * (len(A) + 1)
    for i in range(1, len(A) + 1):
        m = 0
        for j in range(0, i):
            if A[i] > A[j] and F[j] > m:
                m = F[j]
            F[i] = m + 1
        return F[len(A)]

#Distance of reduction changes
def levenstein(A, B):
    F = [[(i + j) if i * j == 0 else 0 for j in range(len(B) + 1)] for i in range(len(A) + 1)]
    for i in range(1, len(A) + 1):
        for j in range(1, len(B) + 1):
            if A[i - 1] == B[j - 1]:
                F[i][j] = F[i-1][j - 1]
            else:
                F[i][j] = 1 + min(F[i - 1][j], F[i][j - 1], F[i - 1][j - 1])
    return F[len(A)][len(B)]
