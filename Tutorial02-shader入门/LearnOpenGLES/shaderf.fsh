varying lowp vec2 varyTextCoord;
uniform sampler2D colorMap;


const lowp vec2 texSize = vec2(1., 1.);

highp vec4 dip_filter(highp mat3 filter, highp sampler2D image, lowp vec2 xy, lowp vec2 texSize)
{
    
    highp vec4 final_color = vec4(0., 0., 0., 0.);
    
    for(int i=0; i<9; i++)
    {
        
        int x = i - (i / 3) * 3 - 1;
        int y = i / 3 - 1;
        
        lowp vec2 new_xy = vec2(xy.x + float(x),
                                xy.y + float(y));
        lowp vec2 new_uv = vec2(new_xy.x / texSize.x, new_xy.y / texSize.y);
        
        final_color += texture2D(colorMap, new_uv) * filter[y + 1][x + 1];
        
    }
    return final_color;
}

void main()
{
    
    gl_FragColor = texture2D(colorMap, varyTextCoord);

    
    highp mat3 filter = mat3(1./16., 1./8.,1./16.,
                       1./8.,1./4.,1./8.,
                       1./16.,1./8.,1./16.);
    
    lowp vec2 xy = vec2(varyTextCoord.x * texSize.x, varyTextCoord.y * texSize.y);
    
    highp vec4 color = dip_filter(filter, colorMap, xy, texSize);
    
    
    gl_FragColor = color;
     
}
