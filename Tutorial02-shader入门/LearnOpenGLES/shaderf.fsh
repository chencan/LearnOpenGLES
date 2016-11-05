varying lowp vec2 varyTextCoord;
uniform sampler2D colorMap;


const lowp vec2 texSize = vec2(1., 1.);

highp vec4 dip_filter(highp mat3 filter, highp vec2 filter_pos_delta[9], highp sampler2D image, highp vec2 xy, highp vec2 texSize)
{
    
    highp vec4 final_color = vec4(0., 0., 0., 0.);
    
    for(int i=0; i<3; i++)
    {
        for(int j=0; j<3; j++)
        {
            highp vec2 new_xy = vec2(xy.x + filter_pos_delta[3*i+j].x,
                               xy.y + filter_pos_delta[3*i+j].y);
            highp vec2 new_uv = vec2(new_xy.x / texSize.x, new_xy.y / texSize.y);
            final_color += texture2D(colorMap, new_uv) * filter[i][j];
        }
    }
    return final_color;
}

void main()
{
    
    gl_FragColor = texture2D(colorMap, varyTextCoord);
    
    
    /*
    highp vec2 filter_pos_delta[9] = highp vec2[](highp vec2(-1., -1.), highp vec2(0., -1.),
                                      highp vec2(1., -1.), highp vec2(-1., 0.),
                                      highp vec2(0., 0.), highp vec2(1., 0.),
                                      highp vec2(-1., 1.), highp vec2(0., 1.), highp vec2(1., 1.));
    */
    highp mat3 filter = mat3(1./16., 1./8.,1./16.,
                       1./8.,1./4.,1./8.,
                       1./16.,1./8.,1./16.);
    
    highp vec2 xy = vec2(varyTextCoord.x * texSize.x, varyTextCoord.y * texSize.y);
    /*
    highp vec4 color = dip_filter(filter, filter_pos_delta,
                            colorMap, xy, texSize);
    
    */
    gl_FragColor = vec4(0., 0., 0., 0.);
     
}
