function res = nmse( TRUTH, COMPARATOR )
    res = sqrt(mean((TRUTH-COMPARATOR).^2));
end