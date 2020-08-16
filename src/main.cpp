#if GPU
#include <SceneGeneration.cuh>
#else
#include <SceneGeneration.hpp>
#endif

int main()
{
    const double aspectR = 1.0;
    int width = 500;
    int height = static_cast<int>(width / aspectR);
    int samplesPerPixel = 10;
    int maxDepth = 50;

    generate::scene(width, height, samplesPerPixel, maxDepth, aspectR);
}
