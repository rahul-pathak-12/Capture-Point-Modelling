function scaled = minmax( series )
    scaled = series - min(series);  
    scaled = scaled / max(scaled);
end