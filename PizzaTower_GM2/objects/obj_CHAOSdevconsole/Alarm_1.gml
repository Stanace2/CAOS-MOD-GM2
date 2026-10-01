var _error = false;
try 
{
	variable_instance_set(fire_obj, fire_var, fire_val);
}
catch ( _exception)
{
	create_record(concat("Error: ", _exception.message),"error");
	_error = true;
}