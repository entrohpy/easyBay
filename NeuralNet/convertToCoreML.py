import coremltools

coreml_model= coremltools.converters.keras.convert('dummy_weights.h5')
coremltools.utils.save_spec(coreml_model, 'my_model.mlmodel')