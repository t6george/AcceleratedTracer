#pragma once
#include <memory>
#include <string>

#include <Texture.cuh>

class ImageTexture : public Texture
{
    const int bytesPerPixel = 3;
    int width, height, componentsPerPicture;
    std::unique_ptr<unsigned char> rgbData;
    int bytesPerScanline;

public:
    HOST ImageTexture(const std::string &filename);
    HOST ~ImageTexture() noexcept = default;

    DEV Vec3 getValue(double u, double v, const Vec3 &point) const override;
};
