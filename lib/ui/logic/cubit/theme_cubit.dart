import 'package:bloc/bloc.dart';
import 'package:simple_calculator/ui/constances/enums.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: AppTheme.dark));
  changeTheme(AppTheme theme) => emit(ThemeState(theme: theme));
}
