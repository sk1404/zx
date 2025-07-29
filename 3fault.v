module basic(a,b,c,e,l);
input a,b,c,e;
output l;
wire h,i,j,k,error;
and g1(h,a,b);
and g2(i,b,c);
not g3(j,i);
or g4(k,h,j);
and g5(l,error,e);
and g6(error,1'b0,k);
endmodule
