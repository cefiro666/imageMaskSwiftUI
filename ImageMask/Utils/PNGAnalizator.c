/*
 * A simple libpng example program
 * http://zarb.org/~gc/html/libpng.html
 *
 * Modified by Yoshimasa Niwa to make it much simpler
 * and support all defined color_type.
 *
 * To build, use the next instruction on OS X.
 * $ brew install libpng
 * $ clang -lz -lpng16 libpng_test.c
 *
 * Copyright 2002-2010 Guillaume Cottenceau.
 *
 * This software may be freely redistributed under the terms
 * of the X11 license.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <png.h>

enum Direction {
    NORTH,
    YEAST,
    SOUTH,
    WEST
};

int width, height;
png_byte color_type;
png_byte bit_depth;
png_bytep *row_pointers = NULL;

void read_png_file(FILE *fp) {
    
    png_structp png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if(!png) abort();
    
    png_infop info = png_create_info_struct(png);
    if(!info) abort();
    
    if(setjmp(png_jmpbuf(png))) abort();
    
    png_init_io(png, fp);
    
    png_read_info(png, info);
    
    width      = png_get_image_width(png, info);
    height     = png_get_image_height(png, info);
    color_type = png_get_color_type(png, info);
    bit_depth  = png_get_bit_depth(png, info);

    if(bit_depth == 16)
        png_set_strip_16(png);
    
    if(color_type == PNG_COLOR_TYPE_PALETTE)
        png_set_palette_to_rgb(png);
    
    // PNG_COLOR_TYPE_GRAY_ALPHA is always 8 or 16bit depth.
    if(color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
        png_set_expand_gray_1_2_4_to_8(png);
    
    if(png_get_valid(png, info, PNG_INFO_tRNS))
        png_set_tRNS_to_alpha(png);
    
    // These color_type don't have an alpha channel then fill it with 0xff.
    if(color_type == PNG_COLOR_TYPE_RGB ||
       color_type == PNG_COLOR_TYPE_GRAY ||
       color_type == PNG_COLOR_TYPE_PALETTE)
        png_set_filler(png, 0xFF, PNG_FILLER_AFTER);
    
    if(color_type == PNG_COLOR_TYPE_GRAY ||
       color_type == PNG_COLOR_TYPE_GRAY_ALPHA)
        png_set_gray_to_rgb(png);
    
    png_read_update_info(png, info);
    
    if (row_pointers) abort();
    
    row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * height);
    for(int y = 0; y < height; y++) {
        row_pointers[y] = (png_byte*)malloc(png_get_rowbytes(png,info));
    }
    
    png_read_image(png, row_pointers);
    
    png_destroy_read_struct(&png, &info, NULL);
}

int process_png_file(char* points) {
    enum Direction direction = NORTH;
    int endX = 0;
    int endY = 0;
    int currentX = 0;
    int currentY = 0;

    for (endY = 0; endY < height; endY++) {
        png_bytep row = row_pointers[endY];
        for (endX = 0; endX < width; endX++) {
            png_bytep px = &(row[endX * 4]);
            if (px[3]) {
                break;
            }
        }
        
        if (endX != width) {
            break;
        }
    }
    
    if (endX == width && endY == height) {
        return 0;
    }
    
    currentX = endX;
    currentY = endY - 1;
    direction = NORTH;
    
    int dotNumber = 0;
    
    while (currentX != endX || currentY != endY) {
        png_bytep row = row_pointers[currentY];
        png_bytep px = &(row[currentX * 4]);
        
        switch (direction) {
            case NORTH:
                if (px[3]) {
                    
                    if (dotNumber == 0) {
                        char *str = (char*)malloc(10 * sizeof(char));
                        sprintf(str, "%d %d\n", currentX, currentY);
                        strncat(points, str, strlen(str));
                        free(str);
                        
                        dotNumber = 5;
                    } else {
                        dotNumber--;
                    }
                    
                    direction = WEST;
                    currentX--;
                } else {
                    direction = YEAST;
                    currentX++;
                }
                
                break;
                
            case YEAST:
                if (px[3]) {
                    
                    if (dotNumber == 0) {
                        char *str = (char*)malloc(10 * sizeof(char));
                        sprintf(str, "%d %d\n", currentX, currentY);
                        strncat(points, str, strlen(str));
                        free(str);
                        
                        dotNumber = 5;
                    } else {
                        dotNumber--;
                    }
                    
                    direction = NORTH;
                    currentY--;
                } else {
                    direction = SOUTH;
                    currentY++;
                }
                break;
                
            case SOUTH:
                if (px[3]) {
                    
                    if (dotNumber == 0) {
                        char *str = (char*)malloc(10 * sizeof(char));
                        sprintf(str, "%d %d\n", currentX, currentY);
                        strncat(points, str, strlen(str));
                        free(str);
                        
                        dotNumber = 5;
                    } else {
                        dotNumber--;
                    }
                    
                    direction = YEAST;
                    currentX++;
                } else {
                    direction = WEST;
                    currentX--;
                }
                break;
                
            case WEST:
                if (px[3]) {
                    
                    if (dotNumber == 0) {
                        char *str = (char*)malloc(10 * sizeof(char));
                        sprintf(str, "%d %d\n", currentX, currentY);
                        strncat(points, str, strlen(str));
                        free(str);
                        
                        dotNumber = 5;
                    } else {
                        dotNumber--;
                    }
                    
                    direction = SOUTH;
                    currentY++;
                } else {
                    direction = NORTH;
                    currentY--;
                }
                break;
        }
    }
    
    return 1;
}

void freeMemory() {
    for(int y = 0; y < height; y++) {
        free(row_pointers[y]);
    }

    free(row_pointers);
    row_pointers = NULL;
}
