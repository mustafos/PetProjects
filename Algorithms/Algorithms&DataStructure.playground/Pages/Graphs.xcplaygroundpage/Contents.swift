import Foundation

struct Queue<T> {
    private var array: [T]
    
    init() {
        array = []
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func add(_ element: T) {
        array.append(element)
    }
    
    mutating func remove() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    func peek() -> T? {
        return array.first
    }
}

struct Stack<T> {
    fileprivate var array = [T]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
    
    var top: T? {
        return array.last
    }
}

class Graph {
    var V = 0                       // number of vertices
    var adj = [[Int]]()             // adjacency list
    
    init(_ V: Int) {
        self.V = V
        for _ in 0..<V {
            adj.append([Int]())     // create empty array of adjacency lists
        }
    }
    
    func addEdge(v: Int, w: Int) {
        adj[v].append(w)
    }
    
    // BFS traversal from a given source s
    func BFS(s: Int) -> [Int] {
        
        var result = [Int]()
        
        // Mark all vertices as not visited
        var visited = adj.map { _ in false }
        
        // Create BFS Queue
        var queue = Queue<Int>()
        
        // Mark first vertex as visited and enqueue
        visited[s] = true
        print("Starting at \(s)")
        queue.add(s)
        result.append(s)
        
        while queue.count > 0 {
            let current = queue.remove()!
            print("De-queueing \(current)")
            
            // Get all the adjacent vertices of the current vertex
            // If adjacent has not being visited, mark visited and enqueue
            
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
                    print("Queuing \(n)")
                    queue.add(n)
                    result.append(n)
                }
            }
         }
        
        return result
    }
    
    // DFS traversal from a given source s
    func DFS(s: Int) -> [Int] {
        
        var result = [Int]()
        
        // Mark all vertices as not visited
        var visited = adj.map { _ in false }
        
        // Create DFS Stack
        var stack = Stack<Int>()
        
        // Mark first vertex as visited and enqueue
//        print("Starting at \(s)")
        visited[s] = true
        stack.push(s)
        
        while stack.count > 0 {
            let current = stack.pop()!
//            print("Popping \(current)")
            result.append(current)
            
            // Iterate over all neighbours adding to queue and popping deep as we go
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
//                    print("Pushing - \(n)")
                    stack.push(n)
                }
            }
        }
        
        return result
    }
}

// Need to have as many vertices as you have edges
let g = Graph(8)
g.addEdge(v: 0, w: 1)
g.addEdge(v: 1, w: 4)
g.addEdge(v: 4, w: 6)
g.addEdge(v: 6, w: 0)
g.addEdge(v: 1, w: 5)
g.addEdge(v: 5, w: 3)
g.addEdge(v: 3, w: 0)
g.addEdge(v: 5, w: 2)
g.addEdge(v: 2, w: 7)

//g.BFS(s: 0)
print(g.DFS(s: 0))

/*
 Graph
               ┌────┐           ┌────┐      ┌────┐
 ┌────────────▶│ 5  │◀──────────▶ 2  │◀─────▶ 7  │
 │             └────┘           └────┘      └────┘
 │                ▲
 │                └─────────┐
 │                          │
 ▼                          ▼
 ┌────┐          ┌────┐     ┌────┐
 │ 1  │◀────────▶│ 0  │◀────▶ 3  │
 └────┘          └────┘     └────┘
 ▲               │
 ▼               ▼
 ┌────┐          ┌────┐
 │ 4  │◀─────────▶ 6  │
 └────┘          └────┘
 
 */

//_________________________________________________________
/*
 You are given in undirected graph consisting of N vertices, numbered from 1 to N, and M edges.
 
 The graph is described by two arrays, A and B, both of length M. A pair A[K] and B[K] for K from 0 to M-1, describe the edge between vertex A[K] and vertex B[K].
 
 Your task is to check whether the given graph contains a path from vertex 1 to vertex N going through all the vertices, one-by-one, in increasing order of the numbers. All connections on the path should be direct.
 
 Write a function, that given an integer N and two arrays A and B of M integers each, returns true if there exists a path from vertex 1 to N going through all vertices, one-by-one, in increasing order, or false other wise.
 
 Example 1:

          ┌─────┐
   ┌──────│  3  │──────┐
   │      └─────┘      │
   │         │         │
┌─────┐      │      ┌─────┐
│  2  │      │      │  4  │
└─────       │      └─────┘
   │      ┌─────┐      │
   └──────│  1  │──────┘
          └─────┘
 
 Given N = 4
       A = [1, 2, 4, 4, 3]
       B = [2, 3, 1, 3, 1]
       Function should return true.
 
 There is a path (1 > 2 > 3 > 4) using edges (1, 2), (2, 3), (4, 3).
 
 Example 2:

          ┌─────┐
   ┌──────│  4  │──────┐
   │      └─────┘      │
   │         │         │
┌─────┐      │      ┌─────┐
│  2  │      │      │  3  │
└─────       │      └─────┘
   │      ┌─────┐      │
   └──────│  1  │──────┘
          └─────┘
 
 Given N = 4
       A = [1, 2, 1, 3]
       B = [2, 4, 3, 4]
       Function should return false.
 
 There is no path (1 > 2 > 3 > 4) as there is no direct connection from vertex 2 to vertex 3.
 
 Example 3:

 ┌─────┐
 │  1  │
 └─────┘
                             
┌─────┐    ┌─────┐    ┌─────┐   ┌─────┐    ┌─────┐
│  2  │────┤  3  │────│  4  │───│  5  │────│  6  │
└─────┘    └─────┘    └─────┘   └─────┘    └─────┘
 
 Given N = 6
       A = [2, 4, 5, 3]
       B = [3, 5, 6, 4]
       Function should return false.
  
 Example 4:

 ┌─────┐    ┌─────┐    ┌─────┐
 │  1  │────┤  2  │────│  3  │
 └─────┘    └─────┘    └─────┘

 Given N = 3
       A = [1, 3]
       B = [2, 2]
       Function should return true.

 
 Example 5:

 ┌─────┐    ┌─────┐    ┌─────┐
 │  2  │────┤  3  │────│  4  │
 └─────┘    └─────┘    └─────┘
 
 Given N = 3
       A = [2, 3]
       B = [3, 4]
       Function should return false.

 */

struct Edge: Equatable {
    let from: Int
    let to: Int
    
    init(_ from: Int, _ to: Int) {
        self.from = from
        self.to = to
    }
}

func solution(_ A: [Int], _ B: [Int]) -> Bool {
    guard A.count > 0 && B.count > 0 else { return false }
    
    // make edges
    var edges: [Edge] = []
    for n in 0..<A.count {
        edges.append(Edge(A[n], B[n]))
    }

    // walk cases
    if A.count == 1 {
        return edges.contains(Edge(1, 2)) || edges.contains(Edge(2, 1))
    } else if A.count == 2 {
        return (edges.contains(Edge(1, 2)) || edges.contains(Edge(2, 1))) &&
               (edges.contains(Edge(2, 3)) || edges.contains(Edge(3, 2)))
    }
    
    for i in 1..<A.count - 1 {
        if edges.contains(Edge(i, i+1)) || edges.contains(Edge(i+1, i)) { continue }
        else { return false }
    }

    return true
}

// Tips
// 1. Work out on paper
// 2. Work on simple case manually.
// 3. Read problem carefully.

//var edges: [Edge] = []
//edges.insert(Edge(1, 2))
//edges.insert(Edge(3, 2))
//
// walk in order
//edges.contains(Edge(1, 2)) || given.contains(Edge(2, 1))
//edges.contains(Edge(2, 3)) || given.contains(Edge(3, 2))



/*
 Example 1:

          ┌─────┐
   ┌──────│  3  │──────┐
   │      └─────┘      │
   │         │         │
┌─────┐      │      ┌─────┐
│  2  │      │      │  4  │
└─────       │      └─────┘
   │      ┌─────┐      │
   └──────│  1  │──────┘
          └─────┘
 
 Given N = 4
       A = [1, 2, 4, 4, 3]
       B = [2, 3, 1, 3, 1]
       Function should return true.

 */
solution([1, 2, 4, 4, 3], [2, 3, 1, 3, 1]) // true

/*
 Example 2:

          ┌─────┐
   ┌──────│  4  │──────┐
   │      └─────┘      │
   │         │         │
┌─────┐      │      ┌─────┐
│  2  │      │      │  3  │
└─────       │      └─────┘
   │      ┌─────┐      │
   └──────│  1  │──────┘
          └─────┘
 
 Given N = 4
       A = [1, 2, 1, 3]
       B = [2, 4, 3, 4]
       Function should return false.
 */
solution([1, 2, 1, 3], [2, 4, 3, 4]) // false

/*
 Example 3:

 ┌─────┐
 │  1  │
 └─────┘
                             
┌─────┐    ┌─────┐    ┌─────┐   ┌─────┐    ┌─────┐
│  2  │────┤  3  │────│  4  │───│  5  │────│  6  │
└─────┘    └─────┘    └─────┘   └─────┘    └─────┘
 
 Given N = 6
       A = [2, 4, 5, 3]
       B = [3, 5, 6, 4]
       Function should return false.
 */
solution([2, 4, 5, 3], [3, 5, 6, 4]) // false

/*
 Example 4:

 ┌─────┐    ┌─────┐    ┌─────┐
 │  1  │────┤  2  │────│  3  │
 └─────┘    └─────┘    └─────┘

 Given N = 3
       A = [1, 3]
       B = [2, 2]
       Function should return true.

 */
solution([1, 3], [2, 2]) // true

/*
 
 Example 5:

 ┌─────┐    ┌─────┐    ┌─────┐
 │  2  │────┤  3  │────│  4  │
 └─────┘    └─────┘    └─────┘
 
 Given N = 3
       A = [2, 3]
       B = [3, 4]
       Function should return false.

 */

solution([2, 3], [3, 4]) // false


