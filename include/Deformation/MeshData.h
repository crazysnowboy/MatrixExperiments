#ifndef MESH_DATA_H
#define MESH_DATA_H
#include <string.h>
#include <vector>
#include <math.h>
#include <iostream>
struct MeshData
{
    int num_vertices;
    int num_triangles;
    std::vector<float> vertices;
    std::vector<int> triangle_list;
    std::vector<float> triangle_color;
    std::vector<float> vertices_nor;
    std::vector<float> triangle_nor;


    void ReadFromFile(const std::string &file_name,const std::string kTriangleListFileName);
    void ReadBlendShape(const std::string &file_name,const std::string kTriangleListFileName);
    void ReadTriangleList(const std::string kTriangleListFileName);
    void WriteToFile(const std::string &file_name);

    void CaculateNorm(float scale);


};

#endif