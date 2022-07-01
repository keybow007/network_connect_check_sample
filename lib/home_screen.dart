import 'package:flutter/material.dart';
import 'package:network_connect_check_sample/failed.dart';
import 'package:network_connect_check_sample/view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ViewModel>(
        builder: (context, vm, child) {
          final isLoading = vm.isLoading;
          final isFailed = vm.isFailed;
          final result = vm.result;
          return (isFailed) ? Failed(): Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        (isLoading
                            ? "データ取得中"
                            : ""),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(result),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("データ取得"),
                    onPressed: (isLoading) ? null : () => _getData(context),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _getData(BuildContext context) {
    final vm = context.read<ViewModel>();
    vm.getData();
  }
}
