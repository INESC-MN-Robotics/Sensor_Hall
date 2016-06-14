classdef OptoDAQ< handle
%


properties (Access = private)
  id_ % ID of the session.
end

methods
  function this = OptoDAQ()
  %Create a new class.
    this.id_ = OptoDAQ_API('new');
  end

  function delete(this)
  %DELETE Destructor.
  OptoDAQ_API('close', this.id_);  % To make it close for sure.
  OptoDAQ_API('delete', this.id_);
  end

  function result = open(this,portname,debugMODE)
  %OPEN function to open a DAQ channel.
    result = OptoDAQ_API('open', this.id_,portname,debugMODE);     
  end
  
  function result = read3D(this,channel)
  %READ3D function waits for a valid sample
   result = OptoDAQ_API('read3D', this.id_,channel); 
    
   result.Fx = double(result.Fx);
   result.Fy = double(result.Fy);
   result.Fz = double(result.Fz);
  end
  
  function result = read6D(this)
  %READ6D function waits for a valid sample
   result = OptoDAQ_API('read6D', this.id_);
   
   result.Fx = double(result.Fx);
   result.Fy = double(result.Fy);
   result.Fz = double(result.Fz);
   result.Tx = double(result.Tx);
   result.Ty = double(result.Ty);
   result.Tz = double(result.Tz);
  end

  function result = sendConfig(this,speed,filter)
  %SendConfig function configures the DAQ
   result = OptoDAQ_API('sendconfig', this.id_,speed,filter);     
  end

  function close(this)
  %DELETE Destructor.
    OptoDAQ_API('close', this.id_);
  end

   


  %%%%% Other functions are not yet implemented (isOpen, etc)%%%%%
end

end
