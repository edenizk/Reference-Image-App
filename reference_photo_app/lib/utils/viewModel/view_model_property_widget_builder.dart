import 'package:flutter/widgets.dart';
import 'package:reference_photo_app/utils/viewModel/view_model.dart';

class ViewModelPropertyWidgetBuilder<TPropertyType>
    extends StreamBuilder<PropertyChangedEvent> {
  ViewModelPropertyWidgetBuilder(
      {Key key,
      @required ViewModel viewModel,
      @required String propertyName,
      @required AsyncWidgetBuilder<PropertyChangedEvent> builder})
      : super(
            key: key,
            builder: builder,
            stream: viewModel.whenPropertyChanged(propertyName));
}
