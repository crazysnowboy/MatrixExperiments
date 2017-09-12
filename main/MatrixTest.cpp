#include <iosfwd>
#include <memory>
#include <iostream>
#include <vector>
#include "fstream"
#include <map>
#include "string.h"
#include "boost/program_options.hpp"
#include "boost/filesystem.hpp"


using namespace std;

extern "C"
{
#include "transformer.h"
#include "mesh_seg.h"
#include "time.h"
#include "umfpack.h"
}

bool Readtxt2Mat(vector<vector<float>> &Mat,const char * filepath)
{
    float element;
    string line_string;
    std::ifstream infile(filepath);
    if( !infile )
    {
        printf("Read mat opening file =%s failed \r\n",filepath);
        return false;
    }
    else
    {
        while(getline(infile,line_string))
        {
            vector<float> row_data;
            std::stringstream stringin(line_string);
            while(stringin >> element)
            {
                row_data.push_back(element);
            }
            Mat.push_back(row_data);

        }
        return true;

    }


}
void SuitParse()
{


    __dt_CHOLMOD_start();
    void *symbolic_obj;        /* for umfpack's symbolic analysis */
    cholmod_sparse   *A;
    cholmod_triplet*  A_tri;
    /* the deformation equation: AtA * x = c, where c = At * C */
    cholmod_sparse *At, *AtA;
    cholmod_dense  *C, *c, *x ,*myx;


    /* allocate for coefficient triplet matrix and rhs vector */


    vector<vector<float>> matA;
    Readtxt2Mat(matA,"../data/metrixdata/A.txt");
    const size_t n_row=matA.size();
    const size_t n_col=matA[0].size();
    A_tri = __dt_CHOLMOD_allocate_triplet((size_t)n_row, (size_t)n_col, 0);
    c = __dt_CHOLMOD_dense_zeros(A_tri->nrow, 1);      /* rhs vector: ncol*1 */
    myx = __dt_CHOLMOD_dense_zeros(A_tri->nrow, 1);      /* rhs vector: ncol*1 */
    x = __dt_CHOLMOD_dense_zeros(A_tri->nrow, 1); /* solution vector: ncol*1 */

    for(int h=0;h<n_row;h++)
    {
        for(int w=0;w<n_col;w++)
        {
            float data=matA.at(h)[w];
            __dt_CHOLMOD_entry(A_tri, w, h, data);
        }
    }


    vector<vector<float>> matX;
    Readtxt2Mat(matX,"../data/metrixdata/x.txt");
    for(int h=0;h<matX.size();h++)
    {
        for(int w=0;w<matX[h].size();w++)
        {
            float data=matX.at(h)[w];
            __dt_CHOLMOD_MODIFYVEC(myx, h*matX[h].size()+w, data);
        }

    }

    A = __dt_CHOLMOD_triplet_to_sparse(A_tri);
    printf("\r\n-------------A------------------\r\n");
    for(int j=0;j<A->nrow;j++)
    {
        for(int i=0;i<A->ncol;i++)
        {
            printf("%f ",__dt_CHOLMOD_REFVEC(A,j*A->ncol+i));
        }
        printf("\r\n");
    }


    printf("\r\n-------------myx-------------------\r\n");
    for(int j=0;j<myx->nrow;j++)
        printf("%f ",__dt_CHOLMOD_REFVEC(myx,j));





    At  = __dt_CHOLMOD_transpose(A);
    //////////////////////////////////////////
    printf("\r\n-------------At------------------\r\n");
    for(int j=0;j<At->nrow;j++)
    {
        for(int i=0;i<At->ncol;i++)
        {
            printf("%f ",__dt_CHOLMOD_REFVEC(At,j*At->ncol+i));
        }
        printf("\r\n");
    }
    AtA = __dt_CHOLMOD_AxAt(At);
    //////////////////////////////////////////
    printf("\r\n-------------AtA------------------\r\n");
    for(int j=0;j<AtA->nrow;j++)
    {
        for(int i=0;i<AtA->ncol;i++)
        {
            printf("%f ",__dt_CHOLMOD_REFVEC(AtA,j*AtA->ncol+i));
        }
        printf("\r\n");
    }

    /* factorize AtA */
    umfpack_di_symbolic(
            (int)AtA->nrow, (int)AtA->ncol,
            (const int*)AtA->p, (const int*)AtA->i, (const double*)AtA->x,
            &symbolic_obj, NULL, NULL);

    void *numeric_obj;     /* umfpack factorization result */

    umfpack_di_numeric(
            (const int*)AtA->p, (const int*)AtA->i, (const double*)AtA->x,
            symbolic_obj, &(numeric_obj), NULL, NULL);

    umfpack_di_free_symbolic(&symbolic_obj);


    __dt_CHOLMOD_Axc(AtA, myx, c);

    printf("\r\n-------------c-------------------\r\n");
    for(int j=0;j<c->nrow;j++)
        printf("%f ",__dt_CHOLMOD_REFVEC(c,j));
    //////////////////////////////////////////
//    C = __dt_CHOLMOD_dense_zeros(n_row,1); //vector
//    for(int j=0;j<n_row;j++)
//    {
//        float data=0.0f;
//        __dt_CHOLMOD_MODIFYVEC(C, j, data);
//    }
//    __dt_CHOLMOD_Axc(At, C, c);



    umfpack_di_solve(UMFPACK_A, (const int*)(AtA->p), (const int*)(AtA->i), (const double*)(AtA->x), (double*)(x->x), (const double*)(c->x), numeric_obj, NULL, NULL);


    printf("\r\n-------------x-------------------\r\n");
    for(int j=0;j<x->nrow;j++)
        printf("%f ",__dt_CHOLMOD_REFVEC(x,j));

    __dt_CHOLMOD_finish();


}
void Cholmod_Test()
{

    __dt_CHOLMOD_start();

    cholmod_sparse   *A;
    cholmod_triplet*  A_tri;
    /* the deformation equation: AtA * x = c, where c = At * C */
    cholmod_sparse *At, *AAt;


    vector<vector<float>> matA;
    Readtxt2Mat(matA,"../data/metrixdata/A.txt");

    const size_t n_row=matA.size();
    const size_t n_col=matA[0].size();
    A_tri = __dt_CHOLMOD_allocate_triplet((size_t)n_row, (size_t)n_col, 0);
    for(int h=0;h<n_row;h++)
    {
        for(int w=0;w<n_col;w++)
        {
            float data=matA.at(h)[w];
            __dt_CHOLMOD_entry(A_tri, w, h, data);
        }
    }
    A = __dt_CHOLMOD_triplet_to_sparse(A_tri);
    printf("\r\n-------------A------------------\r\n");
    for(int j=0;j<A->nrow;j++)
    {
        for(int i=0;i<A->ncol;i++)
        {
            printf("%f ",__dt_CHOLMOD_REFVEC(A,j*A->ncol+i));
        }
        printf("\r\n");
    }

    AAt = __dt_CHOLMOD_AxAt(A);
    //////////////////////////////////////////
    printf("\r\n-------------AAt------------------\r\n");
    for(int j=0;j<AAt->nrow;j++)
    {
        for(int i=0;i<AAt->ncol;i++)
        {
            printf("%f ",__dt_CHOLMOD_REFVEC(AAt,j*AAt->ncol+i));
        }
        printf("\r\n");
    }
    __dt_CHOLMOD_finish();
}
int main(int argc, char *argv[])
{
//    SuitParse();
    Cholmod_Test();

}
