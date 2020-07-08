//
//  PNGAnalizator.h
//  ImageMask
//
//  Created by Виталий Баник on 02.07.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

#ifndef PNGAnalizator_h
#define PNGAnalizator_h

#include "PNGAnalizator.c"

void read_png_file(FILE *fp);
int process_png_file(char* points);
void freeMemory();

#endif /* PNGAnalizator_h */
