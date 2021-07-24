import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/reagent_not_found.dart';
import '../../utils/scale.dart';
import 'description/description_bloc.dart';

class Description extends StatelessWidget {
  final int numberOnu;
  final String riskNumber;

  const Description({
    Key? key,
    required this.numberOnu,
    required this.riskNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = DescriptionBloc();

        bloc.add(
          GetDescriptionEvent(
            numberOnu: numberOnu,
            riskNumber: riskNumber,
          ),
        );

        return bloc;
      },
      child: Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          title: const Text('Reagente'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<DescriptionBloc, DescriptionState>(
            builder: (context, state) {
              if (state is LoadingDescriptionState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SuccessDescriptionState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      state.reagent.nameAndDescription,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.reagent.riskNumber != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 4.0),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Número de risco',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Text(
                                      state.reagent.riskNumber!,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 4.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Número da ONU',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Text(
                                    state.reagent.numberONU.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 4.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Número de Classe de Risco',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              state.reagent.riskClass,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.reagent.limit != null)
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/weight-hanging-solid.png',
                            height: verticalScale(74),
                          ),
                          Column(
                            children: [
                              Text(
                                'Número de Classe de Risco',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .apply(color: Colors.white),
                              ),
                              Text(
                                '${state.reagent.limit} KG',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .apply(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                  ],
                );
              }
              if (state is FailureDescriptionState) {
                if (state.exception is ReagentNotFound) {
                  return const Center(
                    child:
                        Text('Não foi encontrado um reagente correspondente'),
                  );
                }
                return const Center(
                  child: Text('Ocorreu um erro'),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
