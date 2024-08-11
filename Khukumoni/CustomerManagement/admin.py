from django.contrib import admin
from .models import (
    Customer, CustomerPreference, CustomerTag, CustomerNote, Lead,
    Opportunity, Interaction, Task, Segment, Survey, Integration,
    NPSResponse, LifecycleStage, CalendarEvent, Document
)

class CustomerAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'email', 'phone_number', 'city', 'state', 'country', 'created_at', 'updated_at')
    search_fields = ('first_name', 'last_name', 'email', 'phone_number')
    list_filter = ('city', 'state', 'country')

class CustomerPreferenceAdmin(admin.ModelAdmin):
    list_display = ('customer', 'preference_key', 'preference_value', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'preference_key', 'preference_value')

class CustomerTagAdmin(admin.ModelAdmin):
    list_display = ('customer', 'tag_name', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'tag_name')

class CustomerNoteAdmin(admin.ModelAdmin):
    list_display = ('customer', 'note', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'note')

class LeadAdmin(admin.ModelAdmin):
    list_display = ('lead_name', 'contact_email', 'contact_phone', 'company_name', 'source', 'status', 'created_at', 'updated_at')
    search_fields = ('lead_name', 'contact_email', 'contact_phone', 'company_name', 'source', 'status')
    list_filter = ('status', 'source')

class OpportunityAdmin(admin.ModelAdmin):
    list_display = ('customer', 'opportunity_name', 'amount', 'stage', 'close_date', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'opportunity_name', 'amount', 'stage')
    list_filter = ('stage',)

class InteractionAdmin(admin.ModelAdmin):
    list_display = ('customer', 'interaction_type', 'interaction_date', 'notes', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'interaction_type', 'notes')
    list_filter = ('interaction_type', 'interaction_date')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('task_name', 'customer', 'due_date', 'status', 'priority', 'assigned_to', 'created_at', 'updated_at')
    search_fields = ('task_name', 'customer__first_name', 'customer__last_name', 'status', 'priority')
    list_filter = ('status', 'priority', 'due_date')

class SegmentAdmin(admin.ModelAdmin):
    list_display = ('segment_name', 'segment_criteria', 'created_at', 'updated_at')
    search_fields = ('segment_name', 'segment_criteria')

class SurveyAdmin(admin.ModelAdmin):
    list_display = ('survey_name', 'created_at', 'updated_at')
    search_fields = ('survey_name',)

class IntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_name', 'integration_type', 'integration_key', 'integration_secret', 'created_at', 'updated_at')
    search_fields = ('integration_name', 'integration_type', 'integration_key', 'integration_secret')

class NPSResponseAdmin(admin.ModelAdmin):
    list_display = ('customer', 'nps_score', 'feedback', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'nps_score', 'feedback')

class LifecycleStageAdmin(admin.ModelAdmin):
    list_display = ('stage_name', 'created_at', 'updated_at')
    search_fields = ('stage_name',)

class CalendarEventAdmin(admin.ModelAdmin):
    list_display = ('event_title', 'event_description', 'event_start', 'event_end', 'customer', 'created_at', 'updated_at')
    search_fields = ('event_title', 'event_description', 'customer__first_name', 'customer__last_name')
    list_filter = ('event_start', 'event_end')

class DocumentAdmin(admin.ModelAdmin):
    list_display = ('document_name', 'document_type', 'document_url', 'customer', 'created_at', 'updated_at')
    search_fields = ('document_name', 'document_type', 'document_url', 'customer__first_name', 'customer__last_name')

admin.site.register(Customer, CustomerAdmin)
admin.site.register(CustomerPreference, CustomerPreferenceAdmin)
admin.site.register(CustomerTag, CustomerTagAdmin)
admin.site.register(CustomerNote, CustomerNoteAdmin)
admin.site.register(Lead, LeadAdmin)
admin.site.register(Opportunity, OpportunityAdmin)
admin.site.register(Interaction, InteractionAdmin)
admin.site.register(Task, TaskAdmin)
admin.site.register(Segment, SegmentAdmin)
admin.site.register(Survey, SurveyAdmin)
admin.site.register(Integration, IntegrationAdmin)
admin.site.register(NPSResponse, NPSResponseAdmin)
admin.site.register(LifecycleStage, LifecycleStageAdmin)
admin.site.register(CalendarEvent, CalendarEventAdmin)
admin.site.register(Document, DocumentAdmin)
