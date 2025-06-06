import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/utils/dependency_injection.dart';
import 'package:news_app/core/utils/simple_observer.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/presentation/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsEntityAdapter());
  await Hive.openBox<NewsEntity>('newsBox');
  Bloc.observer = SimpleBlocObserver();
  setupServiceLocator();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
