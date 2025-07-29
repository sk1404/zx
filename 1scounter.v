module basic(a,b,c,e,l);
input a,b,c,e;
output l;
wire h,i,j,k,error;
and g1(h,a,error);
and g2(i,error,c);
not g3(j,i);
or g4(k,h,j);
and g5(l,k,e);
and g6(error,1'b0,b);
endmodule
