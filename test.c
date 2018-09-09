auto int x = 10;
auto int y = 20;


//calculator function
int calculator(int Case, int x, int y){
	switch(Case){
		case 1: return add(x,y);
		break;
		case 2: return multiply(x,y);
		break;
		case 3: return quotient(x,y);
		break;
		case 4: return modulo(x,y);
		break;
	}
}

//add function
int add(int x,int y){
	int z = x+y;
	return z;
}

//multiply function
int multiply(int x,int y){
	int z = x * y;
	return z;
}

//quotient function
int quotient(int x,int y){
	int z = x/y;
	return z;
}

//remainder function
int modulo(int x,int y){
	int z = x%y;
	return z;
}

float cal_sin(float n)
{    
    float accuracy = 0.0001, denominator, sinx, sinval;
     
    // Converting degrees to radian
    n = n * (3.142 / 180.0); 
 
    float x1 = n;
     
    // maps the sum along the series
    sinx = n;         
     
    // holds the actual value of sin(n)
    sinval = sin(n);    
    int i = 1;
    do
    {
        denominator = 2 * i * (2 * i + 1);
        x1 = -x1 * n * n / denominator;
        sinx = sinx + x1;
        i = i + 1;
    } while (accuracy <= fabs(sinval - sinx));
    return sinx;
}


// A utility function to swap two elements 
void swap(int* a, int* b) 
{ 
    int t = *a; 
    *a = *b; 
    *b = t; 
} 
  
/* This function takes last element as pivot, places 
   the pivot element at its correct position in sorted 
    array, and places all smaller (smaller than pivot) 
   to left of pivot and all greater elements to right 
   of pivot */
int partition (int arr[], int low, int high) 
{ 
    int pivot = arr[high];    // pivot 
    int i = (low - 1);  // Index of smaller element 
  
    for (int j = low; j <= high- 1; j++) 
    { 
        // If current element is smaller than or 
        // equal to pivot 
        if (arr[j] <= pivot) 
        { 
            i++;    // increment index of smaller element 
            swap(&arr[i], &arr[j]); 
        } 
    } 
    swap(&arr[i + 1], &arr[high]); 
    return (i + 1); 
} 
  
/* The main function that implements QuickSort 
 arr[] --> Array to be sorted, 
  low  --> Starting index, 
  high  --> Ending index */
void quickSort(int arr[], int low, int high) 
{ 
    if (low < high) 
    { 
        /* pi is partitioning index, arr[p] is now 
           at right place */
        int pi = partition(arr, low, high); 
  
        // Separately sort elements before 
        // partition and after partition 
        quickSort(arr, low, pi - 1); 
        quickSort(arr, pi + 1, high); 
    } 
} 
  
/* Function to print an array */
void printArray(int arr[], int size) 
{ 
    int i; 
    for (i=0; i < size; i++) 
        printf("%d ", arr[i]); 
    printf("n"); 
} 
  
// Driver program to test above functions 
int main() 
{ 
    int arr[] = {10, 7, 8, 9, 1, 5}; 
    int n = sizeof(arr)/sizeof(arr[0]); 
    quickSort(arr, 0, n-1); 
    printf("Sorted array: n"); 
    printArray(arr, n); 

	/*checking all the
	calculator cases */

	int Sum = calculator(1,5,6);
	int Prod = calculator(2,5,6);
	int Quotient = calculator(3,12,6);
	int Remainder = calculator(4,12,5);
    return 0; 
} 