import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return ScreenTypeLayout(
          mobile: Builder(builder: (context){
            NewsCubit.get(context).setDesktop(false);
            return buildArticles(list);
          }),
          desktop: Builder(
            builder: (context){
              NewsCubit.get(context).setDesktop(true);

              return Row(
                children: [
                  Expanded(
                    child: buildArticles(list),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          '${list[NewsCubit.get(context).selectedBusinessItem]['description'] ?? 'this '}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

          ),
          breakpoints: const ScreenBreakpoints(
            desktop: 650,
            watch: 300,
            tablet: 300,
          ),
        );
      },
    );
  }
}
