package br.ufscar.sead.loa.remar.statistics

@Singleton
class StatisticFactory {

    public Statistics createStatistics(String gameType) {
        if (gameType == 'questionAndAnswer')
            return new QuestionAndAnswer()
        else if (gameType == 'multipleChoice')
            return new MultipleChoice()
        else if (gameType == 'puzzleWithTime')
            return new PuzzleWithTime()

        return null
    }
}
