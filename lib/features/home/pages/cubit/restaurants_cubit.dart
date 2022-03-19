import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(RestaurantsState());
}
