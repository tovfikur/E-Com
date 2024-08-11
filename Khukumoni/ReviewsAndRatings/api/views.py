from rest_framework import viewsets
from ..models import (
    Review, ReviewReply, ReviewFilter, ReviewReport, ReviewNotification, 
    ReviewAnalytics, ReviewImportExport, ReviewResponseTemplate, ReviewAggregation, 
    ReviewIntegration, ReviewGamification, ReviewAuthentication
)
from .serializers import (
    ReviewSerializer, ReviewReplySerializer, ReviewFilterSerializer, ReviewReportSerializer, ReviewNotificationSerializer, 
    ReviewAnalyticsSerializer, ReviewImportExportSerializer, ReviewResponseTemplateSerializer, ReviewAggregationSerializer, 
    ReviewIntegrationSerializer, ReviewGamificationSerializer, ReviewAuthenticationSerializer
)

class ReviewViewSet(viewsets.ModelViewSet):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer

class ReviewReplyViewSet(viewsets.ModelViewSet):
    queryset = ReviewReply.objects.all()
    serializer_class = ReviewReplySerializer

class ReviewFilterViewSet(viewsets.ModelViewSet):
    queryset = ReviewFilter.objects.all()
    serializer_class = ReviewFilterSerializer

class ReviewReportViewSet(viewsets.ModelViewSet):
    queryset = ReviewReport.objects.all()
    serializer_class = ReviewReportSerializer

class ReviewNotificationViewSet(viewsets.ModelViewSet):
    queryset = ReviewNotification.objects.all()
    serializer_class = ReviewNotificationSerializer

class ReviewAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ReviewAnalytics.objects.all()
    serializer_class = ReviewAnalyticsSerializer

class ReviewImportExportViewSet(viewsets.ModelViewSet):
    queryset = ReviewImportExport.objects.all()
    serializer_class = ReviewImportExportSerializer

class ReviewResponseTemplateViewSet(viewsets.ModelViewSet):
    queryset = ReviewResponseTemplate.objects.all()
    serializer_class = ReviewResponseTemplateSerializer

class ReviewAggregationViewSet(viewsets.ModelViewSet):
    queryset = ReviewAggregation.objects.all()
    serializer_class = ReviewAggregationSerializer

class ReviewIntegrationViewSet(viewsets.ModelViewSet):
    queryset = ReviewIntegration.objects.all()
    serializer_class = ReviewIntegrationSerializer

class ReviewGamificationViewSet(viewsets.ModelViewSet):
    queryset = ReviewGamification.objects.all()
    serializer_class = ReviewGamificationSerializer

class ReviewAuthenticationViewSet(viewsets.ModelViewSet):
    queryset = ReviewAuthentication.objects.all()
    serializer_class = ReviewAuthenticationSerializer

