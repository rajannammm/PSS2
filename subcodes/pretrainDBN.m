function dbn = pretrainDBN(dbn, V, opts)

LayerNum = numel( dbn.rbm );
DropOutRate = zeros(LayerNum,1);

X = V;

if( exist('opts' ) )
 if( isfield(opts,'LayerNum') )
  LayerNum = opts.LayerNum;
 end
 if( isfield(opts,'DropOutRate') )
  DropOutRate = opts.DropOutRate;
  if( numel( DropOutRate ) == 1 )
   DropOutRate = ones(LayerNum,1) * DropOutRate;
  end
 end
 
else
 opts = [];
end

for i=1:LayerNum
	opts.DropOutRate = DropOutRate(i);
    dbn.rbm{i} = pretrainRBM(dbn.rbm{i}, X, opts);
    X0 = X;
    X = v2h( dbn.rbm{i}, X0 );
end
