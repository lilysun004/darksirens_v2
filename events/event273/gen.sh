lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.16108108108108 --fixed-mass2 70.19163163163164 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030678798.0653682 \
--gps-end-time 1030685998.0653682 \
--d-distr volume \
--min-distance 4498.517298705824e3 --max-distance 4498.5372987058245e3 \
--l-distr fixed --longitude -28.266998291015625 --latitude 45.500389099121094 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
