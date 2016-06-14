classdef OptoPorts < handle
%

properties (Access = private)
  id_ % ID of the session.
end

methods
  function this = OptoPorts(pType)
  %DATABASE Create a new database.
    this.id_ = OptoPorts_API('new', pType);
  end

  function delete(this)
  %DELETE Destructor.
    OptoPorts_API('delete', this.id_);
  end

  function result = listPorts(this)
    result = OptoPorts_API('listports', this.id_);        % connectFilter is always TRUE
  end
  
  function result = getLastSize(this)
    result = OptoPorts_API('getlastsize', this.id_);
  end
  
  function result = getAPIversion(this)
    result = OptoPorts_API('getversion', this.id_);
  end

  %%%%% Other functions are not yet implemented (isNewPort, etc)%%%%%
end

end
