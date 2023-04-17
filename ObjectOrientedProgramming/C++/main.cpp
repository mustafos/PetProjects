#include <iostream>
#include <string>
//___Memory_______A[i] === *(A + i)___________________________________________
const int group_max_size = 10;

struct  Student{
    int age;
    int group;
    std::string name;
}

void student_print(const Student &x);

int main()
{
    Student *p_student = new Student[group_max_size];

    for (int k = 0; k < group_max_size; k++)
    {
        p_student[k].age = 17; 
        p_student[k].group = 600 + k; 
        std::cin >> p_student[k].name;
    }
    for (int k = 0; k < group_max_size; k++)
        student_print(p_student[k]);

    return 0;
}

void student_print(const Student &x)
{
    std::cout << x->name << " " << int(x->age) 
              << x->group << std::endl;
}
//___Dynamic_Arrays____________________________________________________________
void square(A);

void printer(double **A, int width, int height)
{
    for(int k = 0; k < 3; k++)
    {
        for(int j = 0; j < 4; j++)
            std::cout << A[k][j] << '\t';
        std::cout << std::endl;
    }
}

//___2D_Arrays______A[k][j] === *(A + k * 4 + j)______________________________
int main2()
{
    int width = 4, height = 3;
    double **A = nullptr;
    A = new double*[height];
    for(int k = 0; k < height; k++)
        A[k] = new double[width];
    
    for(int k = 0; k < height; k++)
        for(int j = 0; j < width; j++)
            A[k][j] = 1 + k*width + j;
            
    printer(A, height, width);
    
    for(int k = 0; k < height; k++);
    
    delete[] A[k];
    delete[] A;
    
    return 0;
}
//___2D_Arrays_________________________________________________________________
