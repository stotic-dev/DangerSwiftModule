import Danger

let danger = Danger()
if let github = danger.github {
    // PRのタイトルが "WIP" を含んでいる場合、警告を出す
    if github.pullRequest.title.contains("WIP") {
        warn("PRが 'WIP' のままです。完了したらタイトルを変更してください。")
    }
    
    // PRの説明が短すぎる場合に警告を出す
    if let body = github.pullRequest.body, body.count < 100 {
        warn("PRの説明が短すぎます。詳細を追加してください。")
    }
    
    // 変更行が500行を超える場合に警告を出す
    let changeFilesCount = github.pullRequest.additions ?? 0
    if changeFilesCount > 500 {
        warn("変更行数が500行を超えています(修正行: \(changeFilesCount))。PRを小さく分けられるか検討してください。")
    }
}

// SwiftLintの設定

 struct LintTarget {
     let directory: String
     let configPath: String
 }

let lintPath = SwiftLint.SwiftlintPath.bin(".build/artifacts/swiftlintplugins/SwiftLintBinary/SwiftLintBinary.artifactbundle/swiftlint-0.58.2-macos/bin/swiftlint")
 let targets: [LintTarget] = [
     LintTarget(directory: "DangerSample", configPath: "DangerSample/.swiftlint.yml")
 ]
 let changeFiles = (danger.git.createdFiles + danger.git.modifiedFiles)
     .filter { $0.fileType == .swift }
     .map { "../" + $0 }

 for target in targets {
     let _ = SwiftLint.lint(.modifiedAndCreatedFiles(directory: target.directory),
                            inline: true,
                            configFile: target.configPath,
                            quiet: true,
                            swiftlintPath: lintPath)
 }
