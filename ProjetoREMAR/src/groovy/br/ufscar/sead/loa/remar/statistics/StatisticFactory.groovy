package br.ufscar.sead.loa.remar.statistics

@Singleton
class StatisticFactory {

    Statistics createStatistics(String gameType) {

        if (gameType == 'questionAndAnswer')
            return new QuestionAndAnswer()
        else if (gameType == 'multipleChoice')
            return new MultipleChoice()
        else if (gameType == 'puzzleWithTime')
            return new PuzzleWithTime()
        else if (gameType == 'shuffleWord')
            return new ShuffleWord()
        else if (gameType == 'dragPictures')
            return new DragPictures()

        return null
    }
}